import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noxi/app/widgets/text_field.dart';

class Dialogs {
  static success(
      BuildContext context, {
        String title = 'Tudo certo!',
        String subtitle = 'Devolução solicitada com sucesso!',
        Function onTap,
        email = "thiagoboeker7k@gmail.com",
        String buttonText = 'Continuar Comprando',
      }) {
    showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.green.shade800,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  static transaction(
      BuildContext context, {
        String title = 'Tudo certo!',
        String subtitle = 'Devolução solicitada com sucesso!',
        Function onTap,
        String buttonText = 'Continuar Comprando',
      }) {
    showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/transaction.png'),
            SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  static transferir(
      BuildContext context, {
        TextEditingController controller,
        TextEditingController valueController,
        String title = 'Tudo certo!',
        String subtitle = 'Devolução solicitada com sucesso!',
        Function onTap,
        String buttonText = 'Continuar Comprando',
      }) {
    showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFieldWidget(
              controller: controller,
              prefixIcon: Icon(Icons.alternate_email),
            ),
            SizedBox(height: 15),
            TextFieldWidget(
              controller: valueController,
            ),
            SizedBox(height: 10),
            CircleAvatar(
              backgroundColor: Colors.green,
              child: IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.send, color: Colors.white,),
              ),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  static confirm(
      BuildContext context, {
        Function onConfirm,
        Function onCancel,
        String confirmText = 'Confirmar Resgate',
        String cancelText = 'Cancelar Resgate',
        String title = 'Deseja confirmarresgate de pontos?',
        String subtitle =
        'Ao confirmar iremos converter seus Pontos em Crédito Financeiro, tem certeza que deseja resgatar?',
      }) {
    List<Map> _renderButtonData(BuildContext context) {
      return [
        {
          'title': confirmText,
          'onTap': onConfirm,
          'color': Theme.of(context).accentColor,
          'textColor': Colors.white,
        },
        {
          'title': cancelText,
          'onTap': onCancel,
          'color': Color(0xffF1F1F1),
          'textColor': Theme.of(context).accentColor,
        },
      ];
    }

    showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Column(
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _renderButtonData(context).map(
                (e) {
              return Container(
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                child: RaisedButton(
                  onPressed: e['onTap'],
                  elevation: 0,
                  color: e['color'],
                  child: Text(
                    e['title'],
                    style: Theme.of(context).textTheme.button.copyWith(
                      color: e['textColor'],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
