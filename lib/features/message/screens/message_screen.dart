
import 'package:blizerpay/common/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: const CommonAppBar(title: "Message"),
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child:Center(child: Text("No Messages yet",style: TextStyle(fontSize: 20),))
        //  ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) => const MessageWidget(
        //     profilePicUrl: "",
        //     subtitle: "9:30",
        //     title:"A new version of the app is now available. Update to enjoy the latest features." ,
        //   ),
          ),
      );
      

    
  }
}