import 'package:flutter/material.dart';
import 'package:task_manager/utils/dimensions.dart';

import '../../../models/todo.dart';

class TaskList extends StatefulWidget {
  final List<Todo> tasks;
  final Function deleteTask;
  final Function editTask;
  final Function(int id, bool isChecked) changeStatus;

  const TaskList(
      {super.key,
      required this.tasks,
      required this.deleteTask,
      required this.editTask,
      required this.changeStatus});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.isEmpty
        ? const Center(
            child: Text("No Tasks Available😅"),
          )
        : ListView.builder(
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(bottom: Dimensions.listBottomPadding),
            physics: const ClampingScrollPhysics(),
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) {
              final Todo task = widget.tasks[index];
              return Dismissible(
                key: Key(task.id.toString()),
                onDismissed: (direction) => widget.deleteTask(task.id),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  elevation: 0,
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.all(2),
                    shape: const RoundedRectangleBorder(),
                    leading: Checkbox(
                      activeColor: Colors.teal,
                      shape: const CircleBorder(),
                      value: task.completed,
                      onChanged: (value) {
                        setState(() {
                          task.completed = value!;
                        });
                        Future.delayed(const Duration(milliseconds: 500), () {
                          widget.changeStatus(task.id, task.completed);
                        });
                      },
                    ),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.brown,
                        ),
                        onPressed: () => widget.editTask(task),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => widget.deleteTask(task.id),
                      ),
                    ]),
                    // controller: tileController,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      task.todo,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.mediumSpace,
                        vertical: Dimensions.smallSpace),
                    children: [
                      Text(
                        task.todo,
                        softWrap: true,
                        textScaler: const TextScaler.linear(1.1),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
