import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/app_module.dart';
import 'package:noxi/app/modules/cart/address/address_bloc.dart';
import 'package:noxi/app/modules/cart/cart_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(CartModule());
  AddressBloc bloc;

  // setUp(() {
  //     bloc = CartModule.to.get<AddressBloc>();
  // });

  // group('AddressBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<AddressBloc>());
  //   });
  // });
}
