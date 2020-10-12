import 'package:dio/dio.dart';
import 'package:noxi/app/modules/authentication/authentication_module.dart';
import 'package:noxi/app/modules/cart/address/address_page.dart';
import 'package:noxi/app/modules/cart/cart_module.dart';
import 'package:noxi/app/modules/cart/creditcard/creditcard_page.dart';
import 'package:noxi/app/modules/cart/transaction/transaction_page.dart';
import 'package:noxi/app/modules/grid/grid_module.dart';

import 'app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:noxi/app/app_widget.dart';
import 'package:noxi/app/modules/home/home_module.dart';

import 'modules/authentication/authentication_bloc.dart';
import 'modules/authentication/form/form_bloc.dart';
import 'modules/authentication/repositories/authentication_repository.dart';
import 'modules/cart/cart_bloc.dart';
import 'modules/cart/repositories/cart_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
        Bind((i) => FormBloc()),
        Bind((i) => AuthenticationRepository(Dio())),
        Bind((i) => AuthenticationBloc()),
        Bind((i) => CartRepository(Dio())),
        Bind((i) => CartBloc()),
  ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: HomeModule()),
        ModularRouter('/auth', module: AuthenticationModule()),
        ModularRouter('/grid', module: GridModule()),
        ModularRouter('/cart', module: CartModule()),
        ModularRouter('/credit_card', child: (_, args) => CreditcardPage(data: args.data,)),
        ModularRouter('/address', child: (_, args) => AddressPage()),
        ModularRouter('/transaction', child: (_, args) => TransactionPage())
  ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
