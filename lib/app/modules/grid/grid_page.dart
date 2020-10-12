import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:noxi/app/models/product_model.dart';
import 'package:noxi/app/modules/authentication/authentication_bloc.dart';
import 'package:noxi/app/modules/authentication/repositories/authentication_repository.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';
import 'package:noxi/app/modules/grid/grid_bloc.dart';
import 'package:noxi/app/widgets/company.dart';
import 'package:noxi/app/widgets/dialog.dart';
import 'package:noxi/app/widgets/product.dart';
import 'package:noxi/app/widgets/text_field.dart';

class GridPage extends StatefulWidget {
  final String title;
  const GridPage({Key key, this.title = "Grid"}) : super(key: key);

  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {

  GridBloc _gridBloc = Modular.get<GridBloc>();
  
  CartBloc _cartBloc = Modular.get<CartBloc>();

  AuthenticationBloc _authBloc = Modular.get<AuthenticationBloc>();

  TextEditingController _searchController;

  int _selectedIndex = 0;

  CurrentUserEvent current;

  NumberFormat format;

  _addToCart(ProductModel product) {
    _cartBloc.addToCart(product);
    Modular.to.pushNamed('/cart');
  }

  _goToCart() {
    Modular.to.pushNamed('/cart');
  }

  _scanQrCode() async {
    final content = await BarcodeScanner.scan();
    Dialogs.transaction(
      this.context,
      title: "Transferencia Completa!"
    );
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(this.context);
    });
  }

  _transferir() async {
    Modular.to.pushNamed('/transaction');
  }

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Todos'
    },
    {
      'name': "Lanches",
    },
    {
      'name': "Mercado",
    },
    {
      'name': 'Oticas'
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    current = _authBloc.currentUser;
    _searchController = TextEditingController();
    _gridBloc.fetchProducts("TODOS");
    _gridBloc.fetchCompanys();
    format = NumberFormat("###,###,###", "BR");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(

        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                  ],)
            )
      ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.00,
        child: FloatingActionButton(
          onPressed: _transferir,
          backgroundColor: Colors.yellow.shade800,
          child: Icon(MdiIcons.swapHorizontal, size: 40,),
        ),
      ),
      body: StreamBuilder(
        stream: _authBloc.currentUserStream,
        builder: (context, userSnapshot) {
          if(!userSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 100,
                    child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: IconButton(
                                    onPressed: _scanQrCode,
                                    icon: Icon(MdiIcons.qrcodeScan, size: 30, color: Colors.green,),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text("${userSnapshot.data.user.name}", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Noxis ${format.format(userSnapshot.data.user.credits)}", style:
                                      TextStyle(color: Colors.green, fontSize: 23, fontWeight: FontWeight.bold)
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: IconButton(
                                    onPressed: _goToCart,
                                    icon: Icon(MdiIcons.cart, size: 35, color: Colors.green,),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Container(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldWidget(
                            width: 290,
                            controller: _searchController,
                            prefixIcon: Icon(Icons.search),
                            labelText: "Procure por Estabelecimentos",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.location_searching, color: Colors.white,)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:30, left: 15),
                  child: Container(
                      height: 60,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ChoiceChip(
                              elevation: 10,
                              backgroundColor: Colors.white,
                              avatar: index == _selectedIndex ? Icon(Icons.check, color: index == _selectedIndex ? Colors.white: Colors.green,size: 20,) : Icon(Icons.adjust, size: 12,),
                              selected: _selectedIndex == index,
                              label: Text(categories[index]['name'], style: TextStyle(color: index == _selectedIndex ? Colors.white : Colors.black.withOpacity(0.7), fontSize: 18, fontWeight: FontWeight.bold),),
                              selectedColor: Colors.green,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _gridBloc.fetchProducts(categories[index]['name']);
                                    _selectedIndex = index;
                                  }
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 10);
                          },
                          itemCount: categories.length
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: StreamBuilder(
                    stream: _gridBloc.productsListStream,
                    builder: (context, snapshot) {
                      if(!snapshot.hasData || snapshot.data.isLoading) {
                        return Container(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Container(
                            height: 300,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (builder, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        _addToCart(snapshot.data.products[index]);
                                      },
                                      child: ProductWidget(product: snapshot.data.products[index])
                                  );
                                },
                                separatorBuilder: (builder, index) {
                                  return SizedBox(width: 10,);
                                },
                                itemCount: snapshot.data.products.length
                            ),
                          )
                      );
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Proximos de voce", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),)
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: StreamBuilder(
                      stream: _gridBloc.companyListStream,
                      builder: (context, snapshot) {
                        if(!snapshot.hasData || snapshot.data.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Container(
                          height: 100,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (builder, index) {
                                return CompanyWidget(company: snapshot.data.companys[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 25,
                                );
                              },
                              itemCount: snapshot.data.companys.length
                          ),
                        );
                      },
                    )
                )

              ],
            ),
          );
        },
      )
    );
  }
}
