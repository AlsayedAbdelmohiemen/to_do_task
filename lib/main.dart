import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubits/settings/settings_state.dart';
import 'data_model/task_model.g.dart';
import 'repositories/preferences_repository.dart';
import 'repositories/task_repository.dart';
import 'screens/edit_task.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'cubits/settings/settings_cubit.dart';
import 'cubits/task/task_cubit.dart';
import 'data_model/task_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  final taskBox = await Hive.openBox<Task>('tasks_box');
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(
          create: (context) => TaskCubit(TaskRepository(taskBox: taskBox)),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) =>
          SettingsCubit(PreferencesRepository(sharedPreferences))
            ..loadPreferences(), // Load preferences when the app starts
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/add-task',
        builder: (context, state) => EditTaskScreen(),
      ),
      GoRoute(
        path: '/edit-task',
        builder: (context, state) {
          final Task task = state.extra as Task;
          return EditTaskScreen(task: task);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        // Default theme in case preferences are not yet loaded
        ThemeData theme = ThemeData.light();

        // Update theme based on the current state
        if (state is SettingsLoaded) {
          theme = state.preferences.theme == 'dark'
              ? ThemeData.dark()
              : ThemeData.light();
        }

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: theme,
        );
      },
    );
  }
}