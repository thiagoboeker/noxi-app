import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';
import 'package:noxi/app/constants.dart';
import 'package:noxi/app/models/company_model.dart';
import 'package:noxi/app/models/product_model.dart';

class ProductList {
  bool isLoading;
  bool isEmpty;
  List<ProductModel> products;

  ProductList({this.isLoading, this.isEmpty, this.products});
}

class CompanyList {
  bool isLoading;
  bool isEmpty;
  List<CompanyModel> companys;

  CompanyList({this.isEmpty, this.isLoading, this.companys});
}

class GridRepository extends Disposable {
  final DioForNative client;

  FirebaseAuth _auth = FirebaseAuth.instance;

  GridRepository(this.client) {
    client.options.baseUrl = API;
  }

  Future<CompanyList> fetchCompanys() async {
    FirebaseUser _user = await _auth.currentUser();
    IdTokenResult _idToken = await _user.getIdToken();

    try {
      Response response = await client.get("/api/user/companys?page=1&page_size=1000", options: Options(
          headers: {
            "Authorization": "Bearer ${_idToken.token}",
            "Content-Type": "application/json"
          }
      ));

      if(response.statusCode == 200) {
        List<CompanyModel> companys = response.data['data'].map<CompanyModel>((e) {
          return CompanyModel.fromJson(e);
        }).toList();
        print(response.data['data']);
        return CompanyList(isEmpty: companys.length <= 0, isLoading: false, companys: companys);
      } else {
        return CompanyList(isEmpty: true, isLoading: false);
      }
    } catch(error) {
      print(error);
      return CompanyList(isLoading: false, isEmpty: true);
    }
  }

  Future<ProductList> fetchProducts(String filtro) async {
    FirebaseUser _user = await _auth.currentUser();
    IdTokenResult _IdToken = await _user.getIdToken();

    try {
      Response response = await client.get("/api/user/products?page=1&page_size=1000&category=${filtro}", options: Options(
        headers: {
          "Authorization": "Bearer ${_IdToken.token}",
          "Content-Type": "application/json"
        }
      ));

      if(response.statusCode == 200) {
        List<ProductModel> products = response.data['data'].map<ProductModel>((e) {
          return ProductModel.fromJson(e);
        }).toList();
        print(response.data['data']);
        return ProductList(isEmpty: products.length <= 0, isLoading: false, products: products);
      } else {
        return ProductList(isEmpty: true, isLoading: false);
      }
    } catch(error) {
      print(error);
      return ProductList(isLoading: false, isEmpty: true);
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
