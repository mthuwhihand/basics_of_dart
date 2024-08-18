import 'package:flutter/material.dart';

class TabBarApp extends StatelessWidget implements PreferredSizeWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.movie), text: 'Movies'),
        Tab(icon: Icon(Icons.favorite), text: 'Liked'),
        Tab(icon: Icon(Icons.bookmark), text: 'Watchlist'),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
