import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/generic_dialog.dart';

Future<void> showUpdateSuccessDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Update',
    content: 'Information update successful',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
