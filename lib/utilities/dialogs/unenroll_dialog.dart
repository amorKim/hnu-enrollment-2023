import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/generic_dialog.dart';

Future<bool> showUnEnrollDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Unenroll',
    content: 'Are you sure you want to unenroll this course?',
    optionBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
