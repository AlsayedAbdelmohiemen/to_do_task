import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  final SharedPreferences _pref;

  PreferencesRepository(this._pref);

  String getTheme() => _pref.getString('theme') ?? 'light';

  Future<void> saveTheme(String theme) => _pref.setString('theme', theme);

}