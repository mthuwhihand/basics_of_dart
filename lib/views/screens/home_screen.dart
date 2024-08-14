import 'dart:io';
import 'package:basics_of_dart/models/movie.dart';
import 'package:basics_of_dart/network/response.dart';
import 'package:basics_of_dart/views/screens/bloc_screen.dart';
import 'package:basics_of_dart/views/screens/provider_screen.dart';
import 'package:basics_of_dart/views/widgets/keep_alive_page_widget.dart';
import 'package:basics_of_dart/views/widgets/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            bottom: const TabBarApp(),
          ),
          body: const TabBarView(
            children: <Widget>[
              KeepAlivePageWidget(page: BlocScreen()),
              KeepAlivePageWidget(page: ProviderScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
