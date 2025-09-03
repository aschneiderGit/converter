// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get titleApp => 'Convertisseur';

  @override
  String get appBar => 'Commencez à convertir ici !';

  @override
  String get updateTime => 'Donnée mise à jour le: ';

  @override
  String get searchCurrency => 'Chercher une devise...';

  @override
  String get noCurrency => 'Pas de devise disponible';

  @override
  String get cancel => 'Annuler';

  @override
  String get selectCurrency => 'Selectiond de device';
}
