import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({ Key? key }) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Likes Page"),
      ),
    );
  }
}