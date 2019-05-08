import 'dart:async';
import 'package:devkit/src/spec/format.cobi.dart';
import 'package:devkit/src/spec/properties.dart';
import 'package:rxdart/rxdart.dart';

typedef MessageHandler = Function(Message);
typedef AuthHandler = Function();

enum Action {
  read,
  write,
  notify
}

String actionToString(Action action) {
  switch (action) {
    case Action.read: return "READ";
    case Action.write: return "WRITE";
    case Action.notify: return "NOTIFY";
  }

  return null;
}

Action stringToAction(String str) {
  switch (str) {
    case "READ": return Action.read;
    case "WRITE": return Action.write;
    case "NOTIFY": return Action.notify;
  }

  return null;
}

class Message<T> {

  final String path;
  final Action action;

  final T payload;

  Message(this.path, this.action, [this.payload]);

}

class MessageStore {

  final Messenger _messenger;
  bool initialized = false;
  Completer<bool> initCompleter;

  final Map<String, dynamic> _cache = <String, dynamic>{};

  MessageStore(this._messenger) {
    _messenger.authHandler = () {
      print("DevKit for dart: Auth successful");
      initialized = true;
      initCompleter?.complete(true);
    };
    _messenger.handler = (msg) {
      if (msg.action == Action.notify && !noCache.contains(msg.path)) {
        _cache[msg.path] = msg.payload;
      }
      _messages.add(msg);
    };
  }

  StreamController<Message> _messages = StreamController.broadcast();

  /// Listens to all the values coming in at the specified property. If that
  /// property is suitable for caching and we do have a cached value laying
  /// around, that value will be prepended to the stream. This behavior can be
  /// turned of via the [noCache] parameter. If [readFirst] is set to true, the
  /// app will be asked to send an updated value to refresh the cache.
  Observable<T> observeValuesOf<T>(String property, {bool noCache = false,
      bool readFirst = false}) {
    if (readFirst)
      read<T>(property);

    final Observable<T> stream = Observable(_messages.stream)
      .where((msg) => msg.path == property)
      .map((msg) => msg.payload as T);
    final cachedItem = _cache[property] as T;

    if (cachedItem != null && !noCache) {
      return stream.startWith(cachedItem);
    } else {
      return stream;
    }
  }

  /// Sends a read message on the specified property to the native app
  void read<T>(String property) {
    _messenger.sendMessage(Message<T>(property, Action.read));
  }

  /// Sends a read message and awaits the first reply coming from the native app
  /// as a response.
  Future<T> readAndGetFirstReply<T>(String property) {
    read<T>(property);
    return observeValuesOf<T>(property, noCache: true).first;
  }

  /// Tries to respond from cache or, if the value wasn't found, sends a read
  /// message to the app to get the value.
  Future<T> replyFromCacheOrRead<T>(String property) {
    final cachedValue = _cache[property] as T;

    if (cachedValue != null)
      return Future.value(cachedValue);

    return readAndGetFirstReply(property);
  }

  /// Sends a write message to the native app
  // I guess we can make this a future that resolves when we get a notify back
  // on this property, but I'm not sure if the app will do that every time.
  void write<T>(String property, T payload) {
    _messenger.sendMessage(Message<T>(property, Action.write, payload));
  }

  Future<bool> init(String token) {
    if (initialized)
      return Future.value(true);
    if (initCompleter != null)
      return initCompleter.future;

    _messenger.performAuth(token, specVersion);
    initCompleter = Completer();
    return initCompleter.future;
  }

  void fakeReceivedMessage(Message msg) {
    _messages.add(msg);
  }

}

/// Class that speaks to a native app.
abstract class Messenger {

  MessageHandler handler;

  AuthHandler authHandler;

  FutureOr<void> performAuth(String token, String version);

  FutureOr<void> sendMessage<T>(Message<T> msg);

}