import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';
import 'package:noxi/app/modules/cart/creditcard/creditcard_bloc.dart';

class CartBalance extends StatefulWidget {
  @override
  _CartBalanceState createState() => _CartBalanceState();
}

class _CartBalanceState extends State<CartBalance> {

  bool _compraComCartao = false;

  CartBloc _cartBloc = Modular.get<CartBloc>();

  AuthenticationBloc _authBloc = Modular.get<AuthenticationBloc>();

  CreditcardBloc _creditcardBloc = Modular.get<CreditcardBloc>();

  _selectCreditCard(int valor, CurrentUserEvent currentUser) {
    if(_compraComCartao) {
      Modular.to.pushNamed('/credit_card', arguments: {'valor': valor, 'user': currentUser});
    } else {
      _creditcardBloc.cartaoSink.add(null);
      Modular.to.pushNamed('/address');
    }
  }

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
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (selected) {
                              setState(() {
                                _compraComCartao = selected;
                              });
                            },
                            value: _compraComCartao,
                          ),
                          Text("Completar Noxis com Cartao de Credito?",
                          style: TextStyle(fontSize: 15),)
                        ],
                      ),
                    )
                  ],
                ),
                Row(
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
                              _selectCreditCard(valor, _authBloc.currentUser);
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(MdiIcons.check, color: Colors.white, size: 30,),
                                  Text("Comprar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
                                ],
                              ),
                              height: 60,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade800,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
                              ),
                            ),
                          )
                        ],
                      )
                    ]
                )
              ],
            );
          } else {
            return Container();
          }
        },
    );
  }
}
