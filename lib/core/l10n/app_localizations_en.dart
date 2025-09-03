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
  String get updateTime => 'Last updated the :';

  @override
  String get searchCurrency => 'Search currency...';

  @override
  String get noCurrency => 'No currencies available';

  @override
  String get cancel => 'Cancel';

  @override
  String get selectCurrency => 'Select Currency';
}
