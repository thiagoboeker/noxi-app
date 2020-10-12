import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';

class FormBloc extends Disposable {
  AuthenticationRepository repository = Modular.get<AuthenticationRepository>();
  //dispose will be called automatically by closing its streams

  Future<SignUpEvent> signUp(Map<String, dynamic> data) {
    print("OK");
    return repository.signUp(data);
  }

  @override
  void dispose() {}
}
