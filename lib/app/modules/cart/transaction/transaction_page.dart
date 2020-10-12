import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:noxi/app/widgets/text_field.dart';

class TransactionPage extends StatefulWidget {
  final String title;
  const TransactionPage({Key key, this.title = "Transacao"})
      : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  TextEditingController _email;
  TextEditingController _valor;

  AuthenticationBloc _authBloc = Modular.get<AuthenticationBloc>();

  _sendPoints() {
    CurrentUserEvent _user = _authBloc.currentUser;
    _user.user.credits -= int.parse(_valor.text);
    _authBloc.currentUserSink.add(_user);
    Modular.to.pushNamed('/grid');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _valor = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:Container(
        height: 80.0,
        width: 80.0,
        child: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Colors.yellow.shade800,
                onPressed: _sendPoints,
                child: Icon(Icons.send, color: Colors.white,),),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.yellow.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 330,
                  height: 150,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: "Digite o email aqui",
                            prefixIcon: Icon(Icons.alternate_email),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _valor,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 25),
                            hintText: "0",
                              prefixIcon: Icon(Icons.control_point_duplicate),
                              border: InputBorder.none
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.4))
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                    hintText: "Escreva uma mensagem aqui",
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5))
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,//Normal textInputField will be displayed
                maxLines: 5,// when user presses enter it will adapt to it
              ),
            )
          ],
        ),
      )
//      body: SingleChildScrollView(
//        child: Padding(
//          padding: EdgeInsets.only(left: 30, right: 30, top: 20),
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Image.asset('assets/money_transfer.png', width: 300, height: 300,),
//              SizedBox(height: 30,),
//              TextFieldWidget(
//                controller: _email,
//                prefixIcon: Icon(Icons.alternate_email),
//              ),
//              SizedBox(height: 15),
//              TextFieldWidget(
//                prefixIcon: Icon(MdiIcons.sendOutline),
//                width: 120,
//                controller: _valor,
//              ),
//              SizedBox(height: 15,),
//            ],
//          ),
//        ),
//      )
    );
  }
}
