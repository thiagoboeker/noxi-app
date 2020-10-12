import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';

class CartRepository extends Disposable {
  final DioForNative client;

  CartRepository(this.client);

  //dispose will be called automatically
  @override
  void dispose() {}
}
