import 'package:converter/core/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/core/theme/app_colors.dart';

void main() {
  testWidgets('text fo the textspan have the good unit', (tester) async {
    final now = DateTime.now();

    final diff = 2;

    final dtMin = now.subtract(Duration(minutes: diff));
    final dtHour = now.subtract(Duration(hours: diff));
    final dtDay = now.subtract(Duration(days: diff));
    final dtMonth = now.subtract(Duration(days: diff * 31));
    final dtYear = now.subtract(Duration(days: diff * 366));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            final spanMinute = getTimeAgo(context, dtMin);
            final spanHour = getTimeAgo(context, dtHour);
            final spanDay = getTimeAgo(context, dtDay);
            final spanMonth = getTimeAgo(context, dtMonth);
            final spanYear = getTimeAgo(context, dtYear);
            expect(spanMinute.text, AppLocalizations.of(context)!.minute(diff));
            expect(spanHour.text, AppLocalizations.of(context)!.hour(diff));
            expect(spanDay.text, AppLocalizations.of(context)!.day(diff));
            expect(spanMonth.text, AppLocalizations.of(context)!.month(diff));
            expect(spanYear.text, AppLocalizations.of(context)!.year(diff));
            return const Placeholder();
          },
        ),
      ),
    );
  });

  testWidgets('colors of the TextSpas is correct', (tester) async {
    final dtOnPrimary = DateTime.now().subtract(const Duration(days: 1));
    final dtWarning = DateTime.now().subtract(const Duration(days: 6));
    final dtError = DateTime.now().subtract(const Duration(days: 15));
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            final spanOnPrimary = getTimeAgo(context, dtOnPrimary);
            final spanWarning = getTimeAgo(context, dtWarning);
            final spanError = getTimeAgo(context, dtError);

            expect(spanOnPrimary.style?.color, Theme.of(context).onPrimary);
            expect(spanWarning.style?.color, Theme.of(context).warning);
            expect(spanError.style?.color, Theme.of(context).error);
            return const Placeholder();
          },
        ),
      ),
    );
  });
}
