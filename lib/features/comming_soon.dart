import 'package:flutter/material.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Coming Soon",style: TextStyle(fontSize: 30),),),
    );
  }
}