import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class CreditcardBloc extends Disposable {
  //dispose will be called automatically by closing its streams

  BehaviorSubject _cartaoController = BehaviorSubject();
  Sink get cartaoSink => _cartaoController.sink;
  Stream get cartaoStream => _cartaoController.stream;

  @override
  void dispose() {
    _cartaoController.close();
  }
}
