import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungshopping/models/user_model.dart';
import 'package:ungshopping/utility/my_style.dart';

class InformationShop extends StatefulWidget {
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  String nameShop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findInformation();
  }

  Future<Null> findInformation() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          nameShop = event.displayName;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(width: 200,
            child: Image(
              image: AssetImage('images/camera.png'),
            ),
          ),
          buildName(),
        ],
      ),
    );
  }

  Widget buildName() =>
      MyStyle().titleH2(nameShop == null ? 'Name ?' : nameShop);
}
