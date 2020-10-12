import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:noxi/app/widgets/basic_button.dart';
import 'package:noxi/app/widgets/raised_button.dart';
import 'package:noxi/app/widgets/text_field.dart';

class AuthenticationPage extends StatefulWidget {
  final String title;
  const AuthenticationPage({Key key, this.title = "Entrar"})
      : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  AuthenticationBloc _authBloc = Modular.get<AuthenticationBloc>();

  _gotoSignup() {
    Modular.to.pushNamed('/auth/sign_up');
  }

  _submit() async {
    LoginEvent login = await _authBloc.login(_emailController.text, _passwordController.text);

    if(login.hasSucceed) {
      CurrentUserEvent currentUser = await _authBloc.getCurrentUser();
      if(currentUser.hasSucceed) {
        _authBloc.currentUserSink.add(currentUser);
        Modular.to.pushNamed('/grid');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
            child: Column(
              children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 70.0),
                        child: IconButton(
                          icon: Icon(Icons.close),
                          iconSize: 45,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25, bottom: 70.0),
                        child: Text(
                          "Seja bem vindo a Noxi!",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      )
                    ],
                ),Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                          child: TextFieldWidget(
                            controller: _emailController,
                              prefixIcon: Icon(Icons.alternate_email),
                              labelText: "Email"
                          ),
                        ),
                      )
                    ],
                  ),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                          child: TextFieldWidget(
                            obscureText: true,
                              prefixIcon: Icon(Icons.lock),
                              controller: _passwordController,
                              labelText: "Senha"
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Container(
                            width: 300,
                            height: 50,
                            child: BasicButton(
                              onTap: _submit,
                              color: Colors.yellow.shade600,
                              text: "Entrar",
                            )
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 35.0, left: 20.0, right: 20.0, top: 100.0),
                        child: GestureDetector(
                          onTap: _gotoSignup,
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Ainda nao tem conta?",  style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black.withOpacity(0.6), fontSize: 19)),
                                  Text("Cadastre-se agora!",  style: TextStyle(color: Colors.blue, fontSize: 19))
                                ],
                              )
                        ),
                      )
                    ],
                )
              ],
            )
          ),
          ),
      ),
    );
  }
}
