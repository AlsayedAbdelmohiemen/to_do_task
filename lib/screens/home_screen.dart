import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubits/task/task_cubit.dart';
import '../cubits/task/task_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {


          if (state is TaskLoaded) {
            final tasks = state.tasks;
            if (tasks.isEmpty) {
              return Center(child: Text('No tasks available.'));
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (_) => context.read<TaskCubit>().deleteTask(task.id),
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    // trailing: Checkbox(
                    //   value: task.isCompleted,
                    //   onChanged: (_) =>
                    //       context.read<TaskCubit>().toggleCompletion(task.id),
                    // ),
                    onTap: () => GoRouter.of(context).go('/edit-task', extra: task),
                  ),
                );
              },
            );
          }



          return Center(child: Text('No tasks available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add_comment_sharp, color: Colors.green),
        onPressed: () => GoRouter.of(context).go('/add-task'),
      ),
    );
  }
}