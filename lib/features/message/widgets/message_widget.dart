import 'package:blizerpay/constents/path_constents.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String profilePicUrl;
  final String title;
  final String subtitle;

  const MessageWidget({
    super.key,
    required this.profilePicUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
           Image.asset(PathConstents.messagePrfile),
          // CircleAvatar(
          //   radius: 30, // You can adjust the radius according to your needs
          //   backgroundImage: NetworkImage(profilePicUrl),
          // ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.w400, 
                    color: Colors.black, 
                  ),
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis, 
                ),
                const SizedBox(height: 4), 
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  maxLines: 2, 
                  overflow: TextOverflow.ellipsis, 
                  softWrap: true,
                ),
              const  SizedBox(height: 30),
               const Divider(thickness: 2,color: Colors.grey,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
