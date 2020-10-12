import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:noxi/app/modules/cart/creditcard/creditcard_bloc.dart';
import 'package:noxi/app/widgets/basic_button.dart';
import 'package:noxi/app/widgets/checkout.dart';

class CreditcardPage extends StatefulWidget {
  final String title;
  final Map<String, dynamic> data;
  const CreditcardPage({Key key, this.title = "Selecione o Cartao", this.data}) : super(key: key);

  @override
  _CreditcardPageState createState() => _CreditcardPageState();
}

class _CreditcardPageState extends State<CreditcardPage> {

  CreditcardBloc _creditcardBloc = Modular.get<CreditcardBloc>();

  int _selected = 0;

  final cards = [
    {
      'ano': '2024',
      'mes': '05',
      'bandeira': 'Visa',
      'numero': '**** **** **** 5566',
      'imageUrl': 'https://cdn.iconscout.com/icon/free/png-256/visa-credit-card-1822954-1547549.png'
    },
    {
      'bandeira': 'MasterCard',
      'ano': '2023',
      'mes': '05',
      'numero': '**** **** **** 7777',
      'imageUrl': 'https://brand.mastercard.com/content/dam/mccom/brandcenter/thumbnails/mastercard_vrt_pos_92px_2x.png'
    },
    {
      'ano': '2025',
      'mes': '05',
      'bandeira': 'Elo',
      'numero': '**** **** **** 6688',
      'imageUrl': 'https://i.pinimg.com/originals/61/e1/e9/61e1e92d1cba837bba6f64f1a03a9b8e.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.yellow.shade800,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selected = index;
                      _creditcardBloc.cartaoSink.add(cards[index]);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(spreadRadius: 5.0, color: Colors.grey.withOpacity(0.2), blurRadius: 5.0)
                        ],
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.withOpacity(0.7)),
                            right: BorderSide(color: Colors.grey.withOpacity(0.7)),
                            left: BorderSide(color: Colors.grey.withOpacity(0.7))
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: CachedNetworkImage(
                                width: 50,
                                height: 80,
                                imageUrl: cards[index]['imageUrl'],
                              )
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${cards[index]['mes']}/${cards[index]['ano']}",
                                style: TextStyle(color: Colors.grey.withOpacity(0.9),fontSize: 16, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "${cards[index]['numero']}",
                                style: TextStyle(color: Colors.grey.withOpacity(0.9),fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          ),
                          _selected == index ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.adjust, color: Colors.blue,)
                        ],
                      ),
                    ),
                  )
                );
              }
            )
          ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Checkout(),
                ),
              )
        ],
      ),
    );
  }
}
