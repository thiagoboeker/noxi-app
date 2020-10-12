import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {

  String text;
  Color borderColor;
  Color primaryColor;
  double height;
  IconData icon;
  CustomButton({this.text, this.borderColor, this.primaryColor, this.height = 45.0, this.icon = Icons.arrow_forward_ios});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      child: Ink(
        decoration: BoxDecoration(
            color: widget.primaryColor,
            borderRadius: BorderRadius.circular(30.0),


        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 20.0),
                      child: Text(widget.text,style:
                        TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          fontSize: 18.0
                        )
                      )
                    )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 60,
                      child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.1),
                          child: Icon(widget.icon, color: Colors.white, size: 15,)
                      )
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

