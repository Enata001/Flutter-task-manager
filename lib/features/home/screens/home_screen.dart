import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/auth/widgets/celevated_button.dart';
import 'package:task_manager/models/todo.dart';
import 'package:task_manager/models/userdata.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/providers/cache_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/navigation.dart';
import '../../../utils/dimensions.dart';
import '../../task/screens/task_screen.dart';
import '../widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isChecked = false;
bool isPending = true;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ToDoProvider>().getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    final Userdata? user = Provider.of<AuthProvider>(context).user;
    final ToDoProvider toDoProvider = Provider.of<ToDoProvider>(context);
    final CacheProvider toProvider = Provider.of<CacheProvider>(context);

print('this is ${toProvider.allTasks}');
    Map<bool, Widget> tabs = {
      true: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          'Pending',
          style: TextStyle(color: (isPending) ? Colors.black : Colors.white70),
        ),
      ),
      false: Text(
        'Completed',
        style: TextStyle(color: (!isPending) ? Colors.black : Colors.white70),
      )
    };
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.teal,
            backgroundImage: NetworkImage(user?.image ?? Constants.avatarLogo),
          ),
        ),
        leadingWidth: 40,
        title: Text(
          'Hi, ${user?.firstName ?? "User"}',
          style:
              Theme.of(context).textTheme.titleLarge?.apply(fontWeightDelta: 2),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await toDoProvider.clear(
                  onSuccess: () => Navigation.skipTo(
                      Navigation.index, toDoProvider.sharedPreferences),
                );
                print(toDoProvider.allTasks);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.smallSpace,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: Dimensions.smallSpace,
            ),
            Row(
              children: [
                Text(
                  'Today\'s Tasks',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tight(
                const Size(double.infinity, Dimensions.slidingButtonWidth),
              ),
              child: CupertinoSlidingSegmentedControl(
                children: tabs,
                onValueChanged: (val) {
                  setState(() {
                    isPending = val!;
                  });
                },
                groupValue: isPending,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: TaskList(
                  deleteTask: (e) => toDoProvider.deleteTask(e),
                  editTask: (Todo e) async {
                    final task = await createOrUpdateTask(
                      context,
                      createOrEditTask: CreateOrEditTask(
                        task: e,
                      ),
                    );
                    if (task != null) {
                      if (task.todo.isNotEmpty) {
                        toDoProvider.updateTask(task);
                      }
                    }
                  },
                  changeStatus: (id, isCheck) =>
                      toDoProvider.changeStatus(id, isChecked),
                  tasks: isPending
                      ? toDoProvider.pendingTasks
                      : toDoProvider.completedTasks),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CElevatedButton(
          action: () async {
            final ids = toDoProvider.allTasks.map((e) => e.id).toList();

            int id = 1;
            if (ids.isEmpty) {
            } else {
              id = ids.last + 1;
            }
            ids.sort();

            Todo? taskDetails = await createOrUpdateTask(context,
                createOrEditTask: CreateOrEditTask(
                  userId: user?.id,
                  id: id,
                ));
            if (taskDetails != null) {
              toDoProvider.addTask(taskDetails);
            }
          },
          title: 'Add a Task',
          icon: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<Todo?> createOrUpdateTask(
  BuildContext context, {
  required Widget createOrEditTask,
}) {
  return showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext contxt) {
        return createOrEditTask;
      });
}
