import 'package:flutter/material.dart';

class BasicButton extends StatefulWidget {
  Color color;
  String text;
  Function onTap;
  BasicButton({this.color, this.text, this.onTap});

  @override
  _BasicButtonState createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 18.0,
      type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(25.0)
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Center(
            child: Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
