import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';
import 'package:noxi/app/widgets/cart_balance.dart';
import 'package:noxi/app/widgets/cart_item.dart';

class CartPage extends StatefulWidget {
  final String title;
  const CartPage({Key key, this.title = "Carrinho"}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  CartBloc _cartBloc = Modular.get<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.yellow.shade800,
      ),
      body: StreamBuilder(
        stream: _cartBloc.cartStream,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(snapshot.data.length <= 0) {
            return Center(
              child: Text("Sem itens no carrinho.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: 500
                  ),
                  child: Column(
                    children: snapshot.data.map<Widget>((e) {
                      return Padding(
                        padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                        child: CartItem(product: e),
                      );
                    }).toList(),
                  ),
                ),
                CartBalance()
              ],
            ),
          );
        },
      ),
    );
  }
}
