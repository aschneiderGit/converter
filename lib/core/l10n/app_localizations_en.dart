// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titleApp => 'Converter';

  @override
  String get appBar => 'Start to convert here !';

  @override
  String get icon => '🇬🇧';

  @override
  String get noConnectionAtInitTitle => 'Need internet connection';

  @override
  String get noConnectionAtInitMessage =>
      'For your first usage of the app you need an internet connection to fetch the initial value of the converter currency';

  @override
  String get searchCurrency => 'Search currency...';

  @override
  String get noCurrency => 'No currencies available';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get enterAmount => 'Enter your amount';

  @override
  String get canAcessDataTitle => 'Can\'t access to the Exchangerate API';

  @override
  String get canAcessDataMessage =>
      'Check your connection internet, or the Exchangerate API status';

  @override
  String get dataUpToDate =>
      'Data already up to date (it refresh only every 24h)';

  @override
  String get dataUpdated => 'Data updated ';

  @override
  String get updateTime => 'Data updated ';

  @override
  String get updateTimeEnd => ' ago';

  @override
  String get attribution => 'Rates By Exchange Rate API';

  @override
  String minute(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String hour(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String day(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String month(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '1 month',
    );
    return '$_temp0';
  }

  @override
  String year(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Cancel';
}
