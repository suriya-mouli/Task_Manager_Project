import 'package:flutter/material.dart';
import 'package:task_manager_project/data/services/api_caller.dart';
import 'package:task_manager_project/data/utils/urls.dart';
import 'package:task_manager_project/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import 'package:task_manager_project/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Add New Task', 
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Task Title'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !_addNewTaskInProgress,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapAddButton, 
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    setState(() {
      _addNewTaskInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.createTaskUrl,
      body: requestBody,
    );

    setState(() {
      _addNewTaskInProgress = false;
    });

    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New task has been added');
    } else {
      showSnackBarMessage(context, response.errorMessage ?? 'Failed to add task');
    }
  }

  void _clearTextFields() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
