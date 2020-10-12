import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/app_module.dart';
import 'package:noxi/app/modules/cart/creditcard/creditcard_bloc.dart';
import 'package:noxi/app/modules/cart/cart_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(CartModule());
  CreditcardBloc bloc;

  // setUp(() {
  //     bloc = CartModule.to.get<CreditcardBloc>();
  // });

  // group('CreditcardBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<CreditcardBloc>());
  //   });
  // });
}
