import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noxi/app/models/company_model.dart';

class CompanyWidget extends StatefulWidget {
  CompanyModel company;

  CompanyWidget({this.company});

  @override
  _CompanyWidgetState createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        )
      ),
      height: 100,
      width: 250,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                )
              ),
              height: 75,
              width: 75,
              child: CachedNetworkImage(
                imageUrl: widget.company.imageUrl,
                width: 50,
                height: 50,
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Expanded(
                 child: Center(
                   child: Text("${widget.company.name}", style: TextStyle(fontWeight: FontWeight.bold)),
                 ),
                ),
                Expanded(
                  child: Center(
                    child: Text("8:00am - 18:00pm"),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.star, size: 13,),
                              Text("4.9", style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.directions_walk, size: 13,),
                              Text("1.5km", style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          )
                        ],
                      )
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
