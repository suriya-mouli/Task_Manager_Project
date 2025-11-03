// completed_task_screen.dart
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const TaskCard(
              statusText: 'Completed',
              statusColor: Colors.green,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}