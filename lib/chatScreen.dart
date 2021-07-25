
import 'package:chaters_app/message.dart';
import 'package:flutter/material.dart';
import 'message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';


class ChatScreen extends StatefulWidget {
  ChatScreen({this.Uid, this.Friendid, this.FriendName});
  final String Uid;
  final String Friendid;
  final String FriendName;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String message;
  String FriendIcon;
  User loggedInUser;
  String Time;
  final fieldText = TextEditingController();

  void clearText()
  {
    fieldText.clear();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    String time = Time;

    createAlertDailog(BuildContext context) {
      return showDialog(

          context: context,
          builder: (context) {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.of(context).pop(true);
            });
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              backgroundColor: Color(0xFF393E46),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Message Sent',
                style: GoogleFonts.josefinSans(
                  color: Colors.white,
                  fontSize: 20,
                ),),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393E46),
        title: Text(widget.FriendName,
            style: GoogleFonts.josefinSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 00,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('images/backapp.jpg'),
                      colorFilter:
                      ColorFilter.mode(Colors.black.withOpacity(0.2),
                          BlendMode.dstATop),
                    fit: BoxFit.cover
                  )
                ),
                height: _size.height*0.8,
                width: _size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('Chatlist')
                        .where('Sender', isEqualTo: widget.Friendid)
                        .where('Reciver', isEqualTo: widget.Uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                          reverse: true,
                          children: snapshot.data.docs.map(
                            (document) {
                         return MessageBoxSender(
                              text: (document['SenderChat']),
                              );
                              }
                          ).toList());
                    }),
              )),
          Positioned(
              bottom: 10,
              child:Row(
                children: <Widget>[
                  SizedBox(
                    width: _size.width*0.03,
                  ),
                 Container(
                    height: _size.height/20,
                    width: _size.width*0.8,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: TextField(
                      onChanged: (value){
                        message =value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type Message',
                       hintStyle: TextStyle(
                         color: Colors.grey
                       ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      textAlign: TextAlign.start,
                      controller: fieldText,
                    ),
                  ),
                  SizedBox(
                    width: _size.width*0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (message != null) {
                        _firestore.collection('Chatlist').add({
                          'SenderChat': message,
                          'Reciver': widget.Friendid,
                          'Sender': widget.Uid,
                          'Time': time,
                        });
                      }
                      clearText();
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      createAlertDailog(context);
                    },
                    child: Container(
                      height: _size.height/20,
                      width: _size.width/10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          color: Colors.grey
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }
}
