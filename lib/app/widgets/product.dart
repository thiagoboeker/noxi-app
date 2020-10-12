import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noxi/app/models/product_model.dart';

class ProductWidget extends StatefulWidget {
  ProductModel product;

  ProductWidget({this.product});

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      child:
      Stack(
        children: [
          Container(
              width: 200,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 5.0, blurRadius: 20, offset: Offset(0, 5))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.1)
                  )
              ),
              height: 278,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CachedNetworkImage(imageUrl: widget.product.imageUrl,width: 150, height: 123, colorBlendMode: BlendMode.hardLight,),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 21),
                        child: Text("${widget.product.name}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black.withOpacity(1.0)))
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${widget.product.price} Noxis",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black.withOpacity(0.7)))
                      ],
                    ),
                  )
                ],
              ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 15),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                      backgroundColor: Colors.yellow.shade600.withOpacity(0.75),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white,)
                  ),
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}
