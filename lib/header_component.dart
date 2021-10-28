import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  var text = "Մուտք";
  double size;

  HeaderContainer(this.text, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange, Colors.orange[300]],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 5,
              right: 10,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 26),
              )),
          Center(
            child: Image.asset(
              "assets/images/mainlogo.png",
              height: size / 2, //MediaQuery.of(context).size.height * 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
