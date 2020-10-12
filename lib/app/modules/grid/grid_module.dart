import 'grid_bloc.dart';
import 'repositories/grid_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'grid_page.dart';

class GridModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => GridBloc()),
        Bind((i) => GridRepository(Dio())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => GridPage()),
      ];

  static Inject get to => Inject<GridModule>.of();
}
