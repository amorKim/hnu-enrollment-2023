import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/generic_dialog.dart';

Future<bool> showConflictDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Conflict or Already Enrolled',
    content:
        'The course schedule conflicts with an already enrolled course or the course has already been enrolled!',
    optionBuilder: () => {
      'OK': null,
    },
  ).then(
    (value) => value ?? false,
  );
}
