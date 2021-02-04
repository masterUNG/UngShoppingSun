import 'package:flutter/material.dart';
import 'package:ungshopping/utility/my_style.dart';


class BuyerService extends StatefulWidget {
  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buyer Service'),),
      drawer: Drawer(child: MyStyle().buildSignOut(context),),
    );
  }
}