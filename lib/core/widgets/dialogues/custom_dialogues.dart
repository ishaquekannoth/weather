import 'package:flutter/widgets.dart';
import 'package:weather/core/widgets/dialogues/generic_dialogues.dart';

Future<bool> showDeleteAccountDialogue(BuildContext context) {
  return showGenericDialogue<bool>(
    context: context,
    title: "Delete the Account?",
    content:
        "Are You sure that you want to delete the account? it cant be undone...",
    optionBuilder: () {
      return {'Cancel': false, 'Delete Account': true};
    },
  ).then((value) => value ?? false);
}

Future<bool> showLogoutDialogue(BuildContext context) {
  return showGenericDialogue<bool>(
    context: context,
    title: "Logout the Account?",
    content: "Are You sure that you want to logout of your  account?",
    optionBuilder: () {
      return {'Cancel': false, 'Logout': true};
    },
  ).then((value) => value ?? false);
}
