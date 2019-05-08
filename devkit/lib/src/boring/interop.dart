import 'package:devkit/src/boring/messages.dart';
import 'package:devkit/src/spec/format.cobi.dart' as format;

import 'dart:js';

/// Class that injects the correct javascript objects into the global scope so
/// that the app backend can talk to your module.
class JavaScriptMessageSender implements Messenger {

  @override
  MessageHandler handler;

  @override
  AuthHandler authHandler;

  bool useAndroidBackend = false;
  bool backendFound = false;

  JavaScriptMessageSender() {
    // Init. Set the window.COBI object so that the native app will recognize
    // us as a devkit app
    final cobi = JsObject(context["Object"] as JsFunction);

    cobi["specVersion"] = format.specVersion;
    cobi["__authenticated"] = (JsObject d) {
      authHandler();
    };

    cobi["__receiveMessage"] = (JsObject d) {
      final path = d["path"] as String;
      final action = stringToAction(d["action"] as String);
      final dynamic payload = format.parseWithPath(d["payload"], path);

      handler(Message<dynamic>(path, action, payload));
    };

    context["COBI"] = cobi;
  }

  dynamic stringify(dynamic object) {
    return context["JSON"].callMethod("stringify", [JsObject.jsify(object)]);
  }

  /// Waits until the app or the simulator is ready before sending data to it.
  Future<void> waitForAvailability() async {
    if (backendFound)
      return;

    while (true) {
      bool androidFound = context.hasProperty("cobijsAndroidImpl");
      bool iosFound = context.hasProperty("webkit")
          && (context["webkit"] as JsObject).hasProperty("messageHandlers");

      if (androidFound) {
        useAndroidBackend = true;
        break;
      } else if (iosFound) {
        useAndroidBackend = false;
        break;
      }

      // no backend available, continue trying
      await Future<void>.delayed(Duration(milliseconds: 500));
    }

    backendFound = true;
  }

  Future<void> _sendData(String channel, dynamic payload) async {
    await waitForAvailability();

    if (useAndroidBackend) {
      context["cobijsAndroidImpl"].callMethod("messageFromJs",
        <dynamic>[channel, stringify(payload)]);
    } else {
      context["webkit"]["messageHandlers"][channel]
          .callMethod("postMessage", [JsObject.jsify(payload)]);
    }
  }

  @override
  Future<void> sendMessage<T>(Message<T> msg) async {
    await waitForAvailability();

    final data = <String, dynamic>{
      "path": msg.path,
      "payload": format.writeWithPath(msg.payload, msg.path),
      "action": actionToString(msg.action)
    };

    await _sendData("cobiShell", data);
  }

  @override
  Future<void> performAuth(String token, String version) async {
    await waitForAvailability();

    final data = {"token": token, "version": version};

    await _sendData("cobiAuth", data);
  }

}