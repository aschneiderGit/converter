import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/views/widgets/curency_selection/currency_dropdown.dart';
import 'package:converter/views/widgets/curency_selection/select_currency_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SelectCurrencyModal - Filter currency', () {
    late TextEditingController searchController;
    late List<Currency> usd;
    late List<Currency> dollars;
    late List<Currency> testCurrencies;
    late CurrencyDropdown mockCurrencyDropdown;

    setUp(() {
      searchController = TextEditingController();
      usd = [Currency(code: 'USD', name: 'American dollar', rate: 1)];
      dollars = [
        Currency(code: 'DOLLAR', name: 'xxx', rate: 1),
        Currency(code: 'HKD', name: 'Hong Kong dollar', rate: 1),
        Currency(code: 'CAD', name: 'Canadian Dollar', rate: 1),
        ...usd,
      ];
      testCurrencies = [
        Currency(code: 'EUR', name: 'Euro', rate: 1),
        Currency(code: 'JPY', name: 'Japonese Yen', rate: 1),
        Currency(code: 'VND', name: 'Vietnamise Dong', rate: 1),
        ...dollars,
      ];

      mockCurrencyDropdown = CurrencyDropdown(defaultCurrency: testCurrencies[0], currencyChanged: (_) {});
    });

    tearDown(() {
      searchController.dispose();
    });

    Widget createTestWidget() {
      return MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SelectCurrencyModal(
            searchController: searchController,
            currencies: testCurrencies,
            currencyDropdown: mockCurrencyDropdown,
          ),
        ),
      );
    }

    testWidgets('Display all currency at initial state', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(testCurrencies.length));
    });

    testWidgets('Filter when we start to type', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'USD');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(usd.length));
      expect(find.ancestor(of: find.text('USD'), matching: find.byType(ListTile)), findsOneWidget);
    });

    testWidgets('Filter by code and name', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Dollar');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(dollars.length));
      expect(find.text('DOLLAR'), findsOneWidget);
      expect(find.text('USD'), findsOneWidget);
      expect(find.text('CAD'), findsOneWidget);
      expect(find.text('HKD'), findsOneWidget);
    });

    testWidgets('The filter is trigger at every change', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);

      await tester.enterText(searchField, 'U');
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('USD'), findsOneWidget);
      expect(find.text('EUR'), findsOneWidget);

      await tester.enterText(searchField, 'US');
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(1));
      expect(find.text('USD'), findsOneWidget);

      await tester.enterText(searchField, 'U');
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('USD'), findsOneWidget);
      expect(find.text('EUR'), findsOneWidget);

      await tester.enterText(searchField, '');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(testCurrencies.length));
    });

    testWidgets('Display none currency if any matches', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'XYZ');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNothing);
    });
  });
}
