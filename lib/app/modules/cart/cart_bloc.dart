import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/models/product_model.dart';
import 'package:noxi/app/models/user_model.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends Disposable {
  //dispose will be called automatically by closing its streams

  void addToCart(ProductModel product) {
    List cart = _cartController.value;
    List novoCart = cart.where((element) => element['product'].id != product.id).toList();
    novoCart.add({'product': product, 'qty': 1});
    cartSink.add(novoCart);
  }

  void removeFromCart(ProductModel product) {
    List cart = _cartController.value;
    List novoCart = cart.where((element) => element['product'].id != product.id).toList();
    cartSink.add(novoCart);
  }

  void addUnit(ProductModel product) {
    List cart = _cartController.value;
    final item = cart.where((element) => element['product'].id == product.id).first;
    List novoCart = cart.where((element) => element['product'].id != product.id).toList();
    novoCart.add({'product': product, 'qty': item['qty'] + 1});
    novoCart.sort((a, b) {
      return a['product'].name.toLowerCase().compareTo(b['product'].name.toLowerCase());
    });
    cartSink.add(novoCart);
  }

  void removeUnit(ProductModel product) {
    List cart = _cartController.value;
    final item = cart.where((element) => element['product'].id == product.id).first;
    List novoCart = cart.where((element) => element['product'].id != product.id).toList();
    novoCart.add({'product': product, 'qty': item['qty'] - 1});
    novoCart.sort((a, b) {
      return a['product'].name.toLowerCase().compareTo(b['product'].name.toLowerCase());
    });
    cartSink.add(novoCart);
  }

  UserModel buy(int valor, CurrentUserEvent currentUser) {
    currentUser.user.credits -= valor;
  }

  BehaviorSubject _cartController = BehaviorSubject.seeded([]);
  Sink get cartSink => _cartController.sink;
  Stream get cartStream => _cartController.stream;

  @override
  void dispose() {
    _cartController.close();
  }
}
