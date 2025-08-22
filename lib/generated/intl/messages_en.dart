// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_title": MessageLookupByLibrary.simpleMessage("Chat Demo"),
        "chat_input_hint":
            MessageLookupByLibrary.simpleMessage("Send message..."),
        "common_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "common_confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "common_ok": MessageLookupByLibrary.simpleMessage("OK"),
        "home_tab_chat": MessageLookupByLibrary.simpleMessage("WeChat"),
        "home_tab_contact": MessageLookupByLibrary.simpleMessage("Contacts"),
        "home_tab_find": MessageLookupByLibrary.simpleMessage("Discover"),
        "home_tab_mine": MessageLookupByLibrary.simpleMessage("Me"),
        "language_settings":
            MessageLookupByLibrary.simpleMessage("Language Settings"),
        "login_password": MessageLookupByLibrary.simpleMessage("Password"),
        "login_submit": MessageLookupByLibrary.simpleMessage("Login"),
        "login_title": MessageLookupByLibrary.simpleMessage("Login"),
        "login_username": MessageLookupByLibrary.simpleMessage("Username")
      };
}
