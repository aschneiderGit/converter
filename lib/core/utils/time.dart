import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

TextSpan getTimeAgo(BuildContext context, DateTime dt) {
  Duration durationDiff = DateTime.now().difference(dt);
  int diff = durationDiff.inHours;
  String text = AppLocalizations.of(context)!.hour(diff);
  ThemeData t = Theme.of(context);
  Color color = t.onPrimary;
  if (diff == 0) {
    diff = durationDiff.inMinutes;
    text = AppLocalizations.of(context)!.minute(diff);
  } else if (diff > 23) {
    diff = durationDiff.inDays;
    text = AppLocalizations.of(context)!.day(diff);
    if (diff > 14) {
      color = t.error;
    } else if (diff > 5) {
      color = t.warning;
    }
    if (diff > 365) {
      diff = diff ~/ 365;
      text = AppLocalizations.of(context)!.year(diff);
    } else if (diff > 30) {
      diff = diff ~/ 30;
      text = AppLocalizations.of(context)!.month(diff);
    }
  }

  return TextSpan(
    text: text,
    style: Theme.of(context).textStyle.copyWith(fontSize: 16, color: color),
  );
}
