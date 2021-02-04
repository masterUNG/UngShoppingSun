import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungshopping/models/user_model.dart';
import 'package:ungshopping/router.dart';
import 'package:ungshopping/utility/my_style.dart';

String initialRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .snapshots()
            .listen((event) {
          UserModel model = UserModel.fromMap(event.data());
          switch (model.typeuser) {
            case 'buyer':
              initialRoute = '/buyerService';
              runApp(MyApp());
              break;
              case 'shoper':
              initialRoute = '/shoperService';
              runApp(MyApp());
              break;
            default:
          }
        });
      } else {
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(primaryColor: MyStyle().darkColor),
    );
  }
}
