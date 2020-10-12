import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/grid/repositories/grid_repository.dart';
import 'package:rxdart/rxdart.dart';

class GridBloc extends Disposable {
  //dispose will be called automatically by closing its streams

  GridRepository _repository = Modular.get<GridRepository>();

  void fetchCompanys() async {
    companyListSink.add(CompanyList(isLoading: true));
    CompanyList companys = await _repository.fetchCompanys();
    companyListSink.add(companys);
  }

  BehaviorSubject _companyListController = BehaviorSubject();
  Sink get companyListSink => _companyListController.sink;
  Stream get companyListStream => _companyListController.stream;

  void fetchProducts(String filtro) async {
    productsListSink.add(ProductList(isLoading: true));
    ProductList productList = await _repository.fetchProducts(filtro);
    productsListSink.add(productList);
  }

  BehaviorSubject _productsListController = BehaviorSubject();
  Sink get productsListSink => _productsListController.sink;
  Stream get productsListStream => _productsListController.stream;

  @override
  void dispose() {
    _companyListController.close();
    _productsListController.close();
  }
}
