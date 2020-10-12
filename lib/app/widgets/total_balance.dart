import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';
import 'package:noxi/app/modules/cart/creditcard/creditcard_bloc.dart';

class TotalBalance extends StatefulWidget {
  Map<String, dynamic> cartao;

  TotalBalance({this.cartao});

  @override
  _TotalBalanceState createState() => _TotalBalanceState();
}

class _TotalBalanceState extends State<TotalBalance> {
  CartBloc _cartBloc = Modular.get<CartBloc>();
  CreditcardBloc _creditcardBloc = Modular.get<CreditcardBloc>();
  AuthenticationBloc _authBloc = Modular.get<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _cartBloc.cartStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
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
                    Text("${numItens} selecionados", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.bold),),
                    Text("${valor} Noxis", style: TextStyle(fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Modular.to.pushNamed('/address');
                      },
                      child: StreamBuilder(
                        stream: _creditcardBloc.cartaoStream,
                        builder: (builder, snapshot) {
                          if(!snapshot.hasData || snapshot.data == null) {
                            return Center(
                              child: Text("Compra sem cartao!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            );
                          }
                          return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snapshot.data['imageUrl'],
                                    width: 50,
                                    height: 50,
                                  ),
                                  Text("${snapshot.data['mes']}/${snapshot.data['ano']}", style: TextStyle(
                                      color: Colors.grey.withOpacity(0.9),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),),
                                  Text("${snapshot.data['numero']}", style: TextStyle(
                                      color: Colors.grey.withOpacity(0.9),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),)
                                ],
                              ),
                              height: 100,
                              width: 220
                          );
                        },
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
