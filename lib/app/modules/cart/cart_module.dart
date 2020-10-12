import 'transaction/transaction_bloc.dart';
import 'address/address_bloc.dart';
import 'creditcard/creditcard_bloc.dart';
import 'repositories/cart_repository.dart';
import 'cart_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'cart_page.dart';

class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => TransactionBloc()),
        Bind((i) => AddressBloc()),
        Bind((i) => CreditcardBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => CartPage()),
      ];

  static Inject get to => Inject<CartModule>.of();
}
