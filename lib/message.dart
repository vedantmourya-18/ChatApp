import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class MessageBoxSender extends StatelessWidget {
  const MessageBoxSender({@required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              text,
              style: GoogleFonts.josefinSans(fontSize: 16,
              fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FriendsBox extends StatelessWidget {
 FriendsBox({@required this.text,@required this.iconText});

  final String text;
  final String iconText;
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: _size.height / 8,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.primaries[_random.nextInt(Colors.primaries.length)],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 7.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Center(child: Text(iconText,
                style: GoogleFonts.bitter(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class text extends StatelessWidget {
  const text({
    Key key,
    @required Size size,
    @required String hint,
    @required Icon icon,
    Function onPressed,
    TextInputType inputType,
  })  : _size = size,
        _hint = hint,
        _icon = icon,
        _onPressed = onPressed,
        _inputType = inputType,
        super(key: key);

  final Size _size;
  final String _hint;
  final Icon _icon;
  final Function _onPressed;
  final TextInputType _inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      height: _size.height / 20,
      width: _size.width /2.2,
      child: TextField(
          keyboardType: _inputType,
          onChanged: _onPressed,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: _hint,
            hintStyle: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
            prefixIcon: _icon,
          )),
    );
  }
}




