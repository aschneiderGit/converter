import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

TextSpan getTimeAgo(BuildContext context, DateTime dt) {
  Duration durationDiff = DateTime.now().difference(dt);
  int diff = durationDiff.inHours;
  String text = AppLocalizations.of(context)!.hour(diff);
  Color color = AppColors.onPrimary;
  if (diff > 23) {
    diff = durationDiff.inDays;
    text = AppLocalizations.of(context)!.day(diff);
    if (diff > 14) {
      color = AppColors.error;
    } else if (diff > 5) {
      color = AppColors.warning;
    }
    if (diff > 365) {
      diff = diff ~/ 365;
      text = AppLocalizations.of(context)!.year(diff);
    } else if (diff > 30) {
      diff = diff ~/ 30;
      text = AppLocalizations.of(context)!.month(diff);
    } else if (diff < 0) {
      diff = durationDiff.inHours;
      text = AppLocalizations.of(context)!.hour(diff);
      if (diff < 0) {
        diff = durationDiff.inMinutes;
        text = AppLocalizations.of(context)!.minute(diff);
      }
    }
  }

  return TextSpan(
    text: text,
    style: Theme.of(context).textStyle.copyWith(fontSize: 16, color: color),
  );
}
