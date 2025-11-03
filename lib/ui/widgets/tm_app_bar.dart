import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/login_screen.dart';
import 'package:task_manager_project/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile});

  final bool? fromUpdateProfile;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (widget.fromUpdateProfile ?? false) {
            return;
          }
          Navigator.pushNamed(context, UpdateProfileScreen.name);
        },
        child: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: 8), // spacing between avatar and column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fullName ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
                Text(
                  AuthController.userModel?.email ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [IconButton(onPressed: _signOut, icon: Icon(Icons.logout))],
    );
  }

  Future<void> _signOut() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.name,
      (predicate) => false,
    );
  }
}
