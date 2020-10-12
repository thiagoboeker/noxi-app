import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/app_module.dart';
import 'package:noxi/app/modules/authentication/form/form_bloc.dart';
import 'package:noxi/app/modules/authentication/authentication_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(AuthenticationModule());
  FormBloc bloc;

  // setUp(() {
  //     bloc = AuthenticationModule.to.get<FormBloc>();
  // });

  // group('FormBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<FormBloc>());
  //   });
  // });
}
