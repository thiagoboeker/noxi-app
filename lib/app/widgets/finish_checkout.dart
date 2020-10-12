import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';
import 'package:noxi/app/widgets/dialog.dart';

class Finish extends StatefulWidget {
  @override
  _FinishState createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  CartBloc _cartBloc = Modular.get<CartBloc>();

  AuthenticationBloc _authBloc = Modular.get<AuthenticationBloc>();

  _sendPoints(int valor) {
    CurrentUserEvent _user = _authBloc.currentUser;
    _user.user.credits -= valor;
    _authBloc.currentUserSink.add(_user);
  }

  _finishCheckout() {
    Dialogs.success(this.context, title: "Parabens!", subtitle: "Seu pedido esta a caminho!");
    Future.delayed(Duration(seconds: 2), () {
      Modular.to.pushNamed('/grid');
      _cartBloc.cartSink.add([]);
    });
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
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Obrigado!", style: TextStyle(fontSize: 25, color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _sendPoints(valor);
                        _finishCheckout();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Finalizar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
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
