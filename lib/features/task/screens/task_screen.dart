import 'package:flutter/material.dart';
import 'package:task_manager/utils/dimensions.dart';

import '../../../models/todo.dart';
import '../../auth/widgets/celevated_button.dart';

class CreateOrEditTask extends StatelessWidget {
  final Todo? task;
  final String? description;
  final int? id;
  final int? userId;

  const CreateOrEditTask({
    super.key,
    this.task,
    this.id,
    this.description = 'Add',
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    String? newText = task?.todo;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.smallSpace),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: MediaQuery.sizeOf(context).width * 0.4),
            child: const Divider(
              thickness: 5,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(
                flex: 2,
              ),
              Text(
                "$description Task",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.apply(fontWeightDelta: 2),
              ),
              const Spacer(
                flex: 1,
              ),
              IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              )
            ],
          ),
          Expanded(
            child: TextFormField(
              initialValue: newText,
              expands: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Please enter task details...',
                filled: true,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              maxLines: null,
              onChanged: (value) {
                newText = value;
                // print(taskDetail);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5, horizontal: Dimensions.smallSpace),
            child: CElevatedButton(
                action: () {
                  if (newText != null) {
                    if (task != null) {
                      final updatedTask = task?.copyWith(todo: newText);
                      Navigator.of(context).pop(updatedTask);
                    } else {
                      Todo newTask =
                          Todo(id: id!, todo: newText!.trim(), userId: userId!);
                      Navigator.of(context).pop(newTask);
                    }
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                title: 'Save'),
          ),
        ],
      ),
    );
  }
}
