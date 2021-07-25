import 'package:chaters_app/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'message.dart';


class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  String FriendName ;
  String FriendId;

  void getCurrentUser() async{
      final user =await _auth.currentUser;
      try {
        if (user != null) {
          loggedInUser = user;
        }
      }
      catch(e){
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
    createAlertDailog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              child: Container(
                height: _size.height / 2,
                width: _size.width / 2,
                decoration: BoxDecoration(
                  color: Color(0xFF393E46),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 00,
                      child: Container(
                        height: _size.height / 3,
                        width: _size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.vertical(
                              top: Radius.zero,
                              bottom: Radius.circular(30),
                            )),
                      ),
                    ),
                    Positioned(
                       top: _size.height/10,
                      left: _size.width/6,
                      right: _size.width/6,
                      child: Container(
                        height: _size.height/9,
                        width: _size.height/9,
                        decoration: BoxDecoration(
                         image: DecorationImage(
                           image: AssetImage('images/face.jpg'),
                         ),
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: _size.height/5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 05),
                        child: text(size: _size,hint: 'Email',icon: Icon(
                          Icons.mail
                        ),
                          onPressed: (value){
                             FriendId = value;
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: _size.height/8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 05),
                        child: text(size: _size,hint: 'Name',icon: Icon(
                            Icons.fiber_new,
                        ),
                          onPressed: (value){
                          FriendName = value;
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: _size.height/30,
                      right: _size.width/25,
                      child: FlatButton(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF393E46),
                          shape: BoxShape.rectangle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                        onPressed: (){
                          _firestore.collection('Friendlist').add(
                            {
                               'FriendId': FriendId,
                               'FriendName':FriendName,
                              'UserId':loggedInUser.email,
                            }
                          );
                          Navigator.pop(context);
                        },
                    ),
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chaters',
        style: GoogleFonts.josefinSans(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: Color(0xFF222831),
        elevation: 20,
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: _size.height ,
                width: _size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('Friendlist').where('UserId', isEqualTo: loggedInUser.email ).snapshots(),
                  builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                        children: snapshot.data.docs.map((document) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context , MaterialPageRoute(builder: (context)
                              {
                                return ChatScreen(
                                  Uid: loggedInUser.email,
                                  Friendid: document['FriendId'],
                                  FriendName: document['FriendName'],
                                );
                              }));
                            },
                            child: FriendsBox(
                              text: (document['FriendName']),
                              iconText: '${document['FriendName'][0]}',
                            ),
                          );
                        }).toList()
                    );
                  }
                ),
              ),
              Positioned(
                bottom: _size.height / 20,
                right: _size.width / 20,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF222831),
                  child: Icon(Icons.add, size:40, color: Colors.white),
                  onPressed: () {
                    createAlertDailog(context);
                  },
                ),
              )
            ],
          )),
    );
  }
}
