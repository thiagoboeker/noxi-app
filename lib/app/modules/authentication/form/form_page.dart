import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/authentication/form/form_bloc.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:noxi/app/widgets/basic_button.dart';
import 'package:noxi/app/widgets/text_field.dart';

class FormPage extends StatefulWidget {
  final String title;
  const FormPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _nameController;
  TextEditingController _passwordConfirmController;

  FormBloc _formBloc = Modular.get<FormBloc>();

  _signUp() async {
    SignUpEvent signUp = await _formBloc.signUp({
      'param': {
        'email': _emailController.text,
        'password': _passwordController.text,
        'name': _nameController.text
      }
    });

    if(signUp.hasSucceed) {
      Modular.to.pushNamed('/auth');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 30, left: 10),
                      child: Text("Venha para a Noxi!", style: Theme.of(context).textTheme.headline5,)
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 25, right: 10),
                        child: Text("Cadastre-se na Noxi e faça parte do melhor e mais divertido programa "
                            "de fidelidade do mundo!",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 20.0),)
                    ),
                  )
                ],
              ),
              Form(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 15.0, bottom: 100.0),
                  child:  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFieldWidget(
                                    prefixIcon: Icon(Icons.person),
                                      width: 300,
                                      controller: _nameController,
                                      labelText: "Nome"
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFieldWidget(
                                    prefixIcon: Icon(Icons.alternate_email),
                                      width: 300,
                                      controller: _emailController,
                                      labelText: "Email"
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFieldWidget(
                                    obscureText: true,
                                    prefixIcon: Icon(Icons.lock),
                                      width: 300,
                                      controller: _passwordController,
                                      labelText: "Senha"
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 20),
                                  child: TextFieldWidget(
                                    obscureText: true,
                                    suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),),
                                    prefixIcon: Icon(Icons.lock),
                                      width: 300,
                                      controller: _passwordConfirmController,
                                      labelText: "Confirm sua Senha"
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 50,
                                  child: BasicButton(
                                    onTap: _signUp,
                                    color: Colors.yellow.shade600,
                                    text: "Enviar",
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                )
              )
            ],
          ),
        )
      )
    );
  }
}
