import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:rxdart/rxdart.dart';

class Login {
  bool isLoading;
  bool isSuccessfull;
  bool isFailed;

  Login({this.isLoading, this.isSuccessfull, this.isFailed});
}

class AuthenticationBloc extends Disposable {
  //dispose will be called automatically by closing its streams
  AuthenticationRepository repository = Modular.get<AuthenticationRepository>();

  Future<LoginEvent> login(String email, password) {
    return repository.login(email, password);
  }

  Future<CurrentUserEvent> getCurrentUser() {
    return repository.getUser();
  }

  BehaviorSubject _currentUser = BehaviorSubject();
  Sink get currentUserSink => _currentUser.sink;
  Stream get currentUserStream => _currentUser.stream;
  get currentUser => _currentUser.value;

  @override
  void dispose() {
    _currentUser.close();
  }
}
