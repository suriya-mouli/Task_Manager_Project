import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager_project/data/models/task_status_count_model.dart';
import 'package:task_manager_project/data/services/api_caller.dart';
import 'package:task_manager_project/data/utils/urls.dart';
import 'package:task_manager_project/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_project/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_project/ui/widgets/task_card.dart';
import 'package:task_manager_project/ui/widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  void initState() {
    super.initState();
    _getAllaskStatusCount();
  }

  Future<void> _getAllaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['date']) {
        list.add(TaskStatusCountModel.formJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: [
            const SizedBox(height: 16),

            SizedBox(
              height: 100,
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenteredProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountByStatusCard(title: '_taskStatusCountList[index].status', count: _taskStatusCountList[index].count);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TaskCard(
                    statusText: 'New',
                    statusColor: Colors.lightBlue,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
  }
}
