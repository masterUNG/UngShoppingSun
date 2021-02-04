import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungshopping/models/user_model.dart';
import 'package:ungshopping/utility/dialog.dart';
import 'package:ungshopping/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;
  String user, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50,
              ),
              Text('No Account ?'),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/createAccount'),
                child: Text('Create Account'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              MyStyle().titleH1('Ung Shopping'),
              buildUser(),
              buildPassword(),
              buildLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle().darkColor),
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(value.user.uid)
            .snapshots()
            .listen((event) {
          UserModel model = UserModel.fromMap(event.data());
          switch (model.typeuser) {
            case 'buyer':
              Navigator.pushNamedAndRemoveUntil(
                  context, '/buyerService', (route) => false);
              break;
            case 'shoper':
              Navigator.pushNamedAndRemoveUntil(
                  context, '/shoperService', (route) => false);
              break;
            default:
          }
        });
      }).catchError(
              (value) => normalDialog(context, value.code, value.message));
    });
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.5,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'User :',
          prefixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.5,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password :',
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: screen * 0.3,
      child: MyStyle().showLogo(),
    );
  }
}
