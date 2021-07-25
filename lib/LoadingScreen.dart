import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class loadingScreen extends StatefulWidget {
  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF92E8FA),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(

            top: _size.height/3,
            child: Container(
              height: _size.height/4,
              width: _size.width/3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Chaters.png"),
                ),
                borderRadius: BorderRadius.circular(300),
              ),
            ),
          ),
          Positioned(

            bottom: _size.height/4,
            child:
            SpinKitFadingCircle(
              size: 50,
              color: Colors.white,
            ),),
        ]
      )

    );
  }
}
