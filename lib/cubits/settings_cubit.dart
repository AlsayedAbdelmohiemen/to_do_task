import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<String> {
  final SharedPreferences prefs;

  ThemeCubit({required this.prefs}) : super(prefs.getString('theme') ?? 'light');

  void changeTheme(String theme) {
    prefs.setString('theme', theme);
    emit(theme);
  }
}