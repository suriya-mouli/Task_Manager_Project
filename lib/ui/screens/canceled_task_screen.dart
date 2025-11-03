// canceled_task_screen.dart
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const TaskCard(
              statusText: 'Canceled',
              statusColor: Colors.redAccent,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}