import 'package:flutter/material.dart';

class TabBarApp extends StatelessWidget implements PreferredSizeWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: <Widget>[
        Tab(
          text: 'Movies',
        ),
        Tab(
          text: 'Likes',
        ),
        Tab(
          text: 'Ratings',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
