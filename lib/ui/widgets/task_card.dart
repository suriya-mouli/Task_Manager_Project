// task_card.dart
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    this.title = 'Title will be here',
    this.description = 'Description of Task',
    this.dueDateText = 'Date: 12-12-2025',
    this.statusText = 'New',
    this.statusColor = Colors.lightBlue,
    this.onDelete,
    this.onEdit,
  });

  final String title;
  final String description;
  final String dueDateText;

  // 👉 the two new parameters you’ll customize per screen
  final String statusText;
  final Color statusColor;

  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // If your Flutter version doesn't support `spacing`, replace with SizedBox gaps
        children: [
          Text(description),
          const SizedBox(height: 8),
          Text(
            dueDateText,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(
                label: Text(statusText),
                backgroundColor: statusColor,
                labelStyle: const TextStyle(color: Colors.white),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              const Spacer(),
              IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: Colors.redAccent)),
              IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: Colors.grey)),
            ],
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}