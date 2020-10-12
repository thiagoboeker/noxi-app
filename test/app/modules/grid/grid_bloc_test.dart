import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/app_module.dart';
import 'package:noxi/app/modules/grid/grid_bloc.dart';
import 'package:noxi/app/modules/grid/grid_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(GridModule());
  GridBloc bloc;

  // setUp(() {
  //     bloc = GridModule.to.get<GridBloc>();
  // });

  // group('GridBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<GridBloc>());
  //   });
  // });
}
