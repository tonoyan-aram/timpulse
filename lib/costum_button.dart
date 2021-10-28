import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Material(
        child: new InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: (){onClick();},
          child: new Ink(
            decoration: BoxDecoration(
              color: Colors.orange,
              gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orange[300]],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),),
            width: double.infinity,
            height: 60,
            child:Container(
              alignment: Alignment.center,
              child: Text(btnText,style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
            ),

          ),
        ),
        color: Colors.transparent,
      ),
    );
  }

}
