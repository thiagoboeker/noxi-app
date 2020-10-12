import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  CartBloc _cartBloc = Modular.get<CartBloc>();

  AuthenticationBloc _authBloc = Modular.get<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _cartBloc.cartStream,
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.length > 0) {
          int numItens = snapshot.data.length;
          int valor = snapshot.data.map((e) {
            return e['qty'] * e['product'].price;
          }).toList().reduce((value, element) {
            return value + element;
          });
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("${numItens} selecionados", style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.bold),),
                    Text("${valor} Noxis", style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Modular.to.pushNamed('/address');
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Endereco de Entrega", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20,),
                          ],
                        ),
                        height: 60,
                        width: 220,
                        decoration: BoxDecoration(
                            color: Colors.green.shade800,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
                        ),
                      ),
                    )
                  ],
                )
              ]
          );
        } else {
          return Container();
        }
      },
    );
  }
}
