import 'form/form_bloc.dart';
import 'form/form_page.dart';
import 'repositories/authentication_repository.dart';
import 'authentication_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'authentication_page.dart';
import 'package:noxi/app/constants.dart';

class AuthenticationModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => FormBloc()),
        Bind((i) => AuthenticationRepository(Dio())),
        Bind((i) => AuthenticationBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => AuthenticationPage()),
        ModularRouter('/sign_up',
            child: (_, args) => FormPage())
      ];

  static Inject get to => Inject<AuthenticationModule>.of();
}
