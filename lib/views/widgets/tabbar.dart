import 'package:flutter/material.dart';

class TabBarApp extends StatelessWidget implements PreferredSizeWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: <Widget>[
        Tab(
          text: 'Dio',
        ),
        Tab(
          text: 'Http',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
