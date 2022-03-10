import 'package:flutter/material.dart';
import 'package:kum_kum/repository/user_repository.dart' as respo;

class ChatDetailsPage extends StatefulWidget {
  const ChatDetailsPage({Key? key}) : super(key: key);

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset("assets/back.png"),
            Column(
              children: [
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(7),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(respo.currentUser.value.avatar,height: 70,width: 70,fit: BoxFit.cover)) ,
                  ),
                ),
                SizedBox(height: 5),
              ],
            )


          ],
        ),
      ),
      body: Container()
    );
  }
}
