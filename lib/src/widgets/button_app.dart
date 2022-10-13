import 'package:flutter/material.dart';
import 'package:uber_clone_flutter_udemy/src/utils/colors.dart' as utils;

class ButtonApp extends StatelessWidget {
  Color color;
  Color textColor;
  String text;
  IconData icon;
  Function onPressed;

  ButtonApp(
      {this.textColor = Colors.white,
      this.color = Colors.black,
      @required this.text,
      this.icon = Icons.arrow_forward_ios,
      this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      textColor: textColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        // para definir un elemento encima de otro, el ultimo escrito tiene mas prevalencia
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
              child: CircleAvatar(
                radius: 15,
                child: Icon(
                  icon,
                  color: utils.Colors.ubberCloneColor,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
