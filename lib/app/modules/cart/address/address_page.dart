import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:noxi/app/modules/cart/cart_bloc.dart';
import 'package:noxi/app/widgets/basic_button.dart';
import 'package:noxi/app/widgets/finish_checkout.dart';
import 'package:noxi/app/widgets/text_field.dart';
import 'package:noxi/app/widgets/total_balance.dart';

class AddressPage extends StatefulWidget {
  final String title;
  const AddressPage({Key key, this.title = "Finalizar Pedido"}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  CartBloc _cartBloc = Modular.get<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
                stream: _cartBloc.cartStream,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Container(
                    constraints: BoxConstraints(
                      minHeight: 300
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10,);
                          },
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              height: 90,
                              width: 60,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          CachedNetworkImage(
                                            width: 80,
                                            height: 80,
                                            imageUrl: snapshot.data[index]['product'].imageUrl,
                                          ),
                                          Text("${snapshot.data[index]['product'].name}", style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(MdiIcons.closeOutline, size: 40, color: Colors.red,)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("${snapshot.data[index]['qty']}",
                                                style: TextStyle(fontSize: 30),)
                                            ],
                                          )
                                        ],
                                      ),
                                      Icon(MdiIcons.equal),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("${snapshot.data[index]['qty'] * snapshot.data[index]['product'].price}",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                  );
                }
            ),
            TotalBalance(),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.6))
                  )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Endereço", style: TextStyle(fontSize: 25, color: Colors.grey.withOpacity(0.9)),)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  child:  TextFieldWidget(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Endereco",
                  ),
                )
              ],
            ),
            SizedBox(height: 60,),
            Finish()
          ],
        ),
      )
    );
  }
}
