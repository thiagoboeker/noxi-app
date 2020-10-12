import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';

class CartItem extends StatefulWidget {
  Map<String, dynamic> product;

  CartItem({this.product});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  CartBloc _cartBloc = Modular.get<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              _cartBloc.removeFromCart(widget.product['product']);
            },
            iconSize: 35,
            icon: Icon(Icons.close),
          ),
          CachedNetworkImage(imageUrl: widget.product['product'].imageUrl, width: 60, height: 100,),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text("${widget.product['product'].name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black.withOpacity(1.0))),
          ),
         Padding(
           padding: EdgeInsets.only(left: 10),
           child:  Row(
             children: [
               Container(
                 height: 50,
                 width: 30,
                 decoration: BoxDecoration(
                     color: Colors.transparent
                 ),
                 child: IconButton(
                     onPressed: () {
                       if(widget.product['qty'] > 1) {
                         _cartBloc.removeUnit(widget.product['product']);
                       }
                     },
                     icon: Icon(Icons.remove, color: Colors.redAccent,),
                   ),
                 ),
               Container(
                 height: 50,
                 width: 40,
                 decoration: BoxDecoration(
                     color: Colors.transparent
                 ),
                 child: Center(
                   child: Text("${widget.product['qty']}",
                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black.withOpacity(1.0))),
                 ),
               ),
               Container(
                 height: 50,
                 width: 30,
                 decoration: BoxDecoration(
                     color: Colors.transparent
                 ),
                 child: IconButton(
                     onPressed: () {
                       _cartBloc.addUnit(widget.product['product']);
                     },
                     icon: Icon(Icons.add, color: Colors.green,),
                   ),
                 ),
             ],
           ),
         )
        ],
      ),
    );
  }
}
