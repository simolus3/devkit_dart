import 'dart:async';

import 'package:devkit/devkit.dart';
import 'package:devkit/src/boring/messages.dart';
import 'package:devkit/src/spec/properties.dart';

class ContactResult {

  final ContactData _data;

  const ContactResult.withResult(this._data);
  const ContactResult.dismissed() : _data = null;

  /// Whether the contact chooser has been closed normally and a contact has
  /// been selected.
  bool get hasResult => _data != null;
  /// Whether this contact chooser has been dismissed.
  bool get wasDismissed => _data == null;

  /// If a contact has been selected, returns information about that contact.
  /// Otherwise, that is the contact chooser [wasDismissed], an error will be
  /// thrown.
  ContactData get contact {
    if (wasDismissed)
      throw StateError("Tried to get the contact of a dimissed contact picker.");
    return _data;
  }
}

/// Contains some additional logic to detect dismissed contact pickers.
class ContactPicker {

  MessageStore _msgs;
  Completer<ContactResult> _completer;

  ContactPicker(this._msgs) {
    // Thumb controller actions will be blocked while the contact picker is open.
    // Thus, if we assume the picker to be open and receive a thumb controller
    // event, we know that the picker has been dismissed.
    _msgs.observeValuesOf<ThumbControllerAction>(Hub.externalInterfaceAction)
      .listen((action) {
        _emitAndFinish(ContactResult.dismissed());
    });

    _msgs.observeValuesOf<ContactData>(App.contact).listen((data) {
      _emitAndFinish(ContactResult.withResult(data));
    });
  }

  void _emitAndFinish(ContactResult result) {
    _completer?.complete(result);
    _completer = null;
  }

  Completer<ContactResult> _createPrompt() {
    _msgs.read<ContactData>(App.contact);
    return new Completer<ContactResult>();
  }

  Future<ContactResult> showContactPrompt() {
    return (_completer ??= _createPrompt()).future;
  }

}