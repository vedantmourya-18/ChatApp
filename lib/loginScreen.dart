import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final fieldText1 = TextEditingController();
    final fieldText2 = TextEditingController();

    void clearText1()
    {
      fieldText1.clear();
    }
    void clearText2()
    {
      fieldText2.clear();
    }

    return Scaffold(
      body: Container(
        width: _size.width,
        decoration: BoxDecoration(
          color: Color(0xFF393E46),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           CircleAvatar(
             backgroundColor: Colors.white,
             radius: 70,
             child: Center(
               child: Text("C",
               style: GoogleFonts.righteous(
                 color: Color(0xFF393E46),
                 fontWeight: FontWeight.bold,
                 fontSize: 100
               ),),
             ),
           ),
            SizedBox(
              height: 10,
            ),
            Text(
              'CHATERS',
              style: GoogleFonts.righteous(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            textbox(

              inputType: TextInputType.emailAddress,
               onPressed: (value){
                 email = value;
               },
              size: _size,
              hint: 'Email',
              icon: Icon(
                Icons.email,
                color: Color(0xFF393E46),
              ),
              Controller: fieldText1,
            ),
            SizedBox(
              height: 20,
            ),
            textbox(
              onPressed: (value){
                password = value;
              },
              size: _size,
              hint: 'Password',
              icon: Icon(
                Icons.lock,
                color: Color(0xFF393E46),
              ),
              Controller: fieldText2,
            ),
            SizedBox(
              height: 20,
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Container(
                 height: _size.height/20,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: TextButton(
                   onPressed: () async {
                     try {
                       final newUser = await _auth.createUserWithEmailAndPassword(
                           email: email, password: password);
                       if(newUser != Null){
                         Navigator.pushNamed(context, "/FriendsList");
                       }
                     }
                     catch(e) {
                       print(e);
                     }
                     clearText1();
                     clearText2();
                   },
                   child:
                   Text('Login',style: GoogleFonts.righteous(
                     color: Color(0xFF393E46),
                   ),),
                 ),
               ),
               SizedBox(
                 width:10,
               ),
               Container(
                 height: _size.height/20,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: TextButton(
                   onPressed: () async {

                     try {
                       final newUser =
                       await _auth.signInWithEmailAndPassword(
                           email: email, password: password);
                       if (newUser != null) {
                         Navigator.pushNamed(context, "/FriendsList");
                       }
                     } on FirebaseAuthException catch (e) {
                       return Container(
                         child: Center(
                           child: Text(
                               "Error"
                           ),
                         ),
                       );
                     }
                        clearText1();
                     clearText2();
                   },
                   child:
                   Text('SignUp',style: GoogleFonts.righteous(
                     color: Color(0xFF393E46),
                   ),),
                 ),
               )
             ],
           )
          ],
        ),
      ),
    );
  }
}

class textbox extends StatelessWidget {
const textbox({
Key key,
@required Size size,
@required String hint,
@required Icon icon,
  Function onPressed,
  TextInputType inputType,
  TextEditingController Controller,
})  : _size = size,
_hint = hint,
_icon = icon,
_onPressed = onPressed,
_inputType = inputType,
_controller = Controller,
super(key: key);

final Size _size;
final String _hint;
final Icon _icon;
final Function _onPressed;
final TextInputType _inputType;
final TextEditingController _controller;

@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    height: _size.height / 20,
    width: _size.width / 2,
    child: Center(
      child: TextField(
        keyboardType: _inputType,
        onChanged: _onPressed,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: _hint,
            hintStyle: TextStyle(
                color: Color(0xFF393E46), fontWeight: FontWeight.bold),
            prefixIcon: _icon,
          ),
      controller: _controller,
      ),
    ),
  );
}
}
