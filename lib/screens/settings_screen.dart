import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubits/settings/settings_cubit.dart';
import '../cubits/settings/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => GoRouter.of(context).go('/'),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is SettingsLoaded) {
            final preferences = state.preferences;
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                ListTile(
                  title: Text('Theme'),
                  trailing: Switch(
                    value: preferences.theme == 'dark',
                    onChanged: (value) {
                      final newTheme = value ? 'dark' : 'light';
                      context.read<SettingsCubit>().changeTheme(newTheme);
                    },
                  ),
                ),
              ],
            );
          }

          return Center(child: Text('No preferences available.'));
        },
      ),
    );
  }
}