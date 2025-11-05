import 'package:converter/core/constants/alert_dialog_endpoint.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final bool showCancel;
  final String okText;
  final String cancelText;

  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.message,
    this.showCancel = false,
    this.okText = 'OK',
    this.cancelText = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = showCancel
        ? <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, AlertDialogEndpoint.cancel),
              child: Text(cancelText, style: Theme.of(context).textStyle.copyWith(color: AppColors.primaryVariant)),
            ),
          ]
        : [];
    actions.add(
      TextButton(
        onPressed: () => Navigator.pop(context, AlertDialogEndpoint.ok),
        child: Text(okText, style: Theme.of(context).textStyle.copyWith(color: AppColors.primaryVariant)),
      ),
    );

    return AlertDialog(title: Text(title), content: Text(message), actions: actions);
  }
}
