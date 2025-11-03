import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/canceled_task_screen.dart';
import 'package:task_manager_project/ui/screens/completed_task_screen.dart';
import 'package:task_manager_project/ui/screens/new_task_screen.dart';
import 'package:task_manager_project/ui/screens/progress_task_screen.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  static const String  name = '/dashboard';

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    // You can replace these placeholders with your actual screen widgets
    NewTaskScreen(), // New Tasks Screen
    ProgressTaskScreen(), // Progress Tasks Screen
    CanceledTaskScreen(), // Cancelled Tasks Screen
    CompletedTaskScreen(), // Completed Tasks Screen
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
