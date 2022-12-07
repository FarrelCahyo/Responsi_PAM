// Farrel Cahyo Awangga
// 124200064
// SI - C

import 'package:flutter/material.dart';
import 'package:responsi_124200064/list_matches.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsi Mobile 124200064',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ListPage(),
    );
  }
}