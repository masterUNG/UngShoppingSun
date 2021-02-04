import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungshopping/models/user_model.dart';
import 'package:ungshopping/utility/dialog.dart';
import 'package:ungshopping/utility/my_style.dart';

class CreateAccoun extends StatefulWidget {
  @override
  _CreateAccounState createState() => _CreateAccounState();
}

class _CreateAccounState extends State<CreateAccoun> {
  double screen;
  String typeUser, name, email, password;

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.5,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          hintText: 'Display Name :',
          prefixIcon: Icon(Icons.fingerprint),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.5,
      child: TextField(
        onChanged: (value) => email = value.trim(),
        decoration: InputDecoration(
          hintText: 'Email :',
          prefixIcon: Icon(Icons.email_outlined),
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
        decoration: InputDecoration(
          hintText: 'Password :',
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildName(),
                  buildTitle(),
                  buildBuyer(),
                  buildShoper(),
                  buildEmail(),
                  buildPassword(),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildButtonCreateAccount(),
            ],
          )
        ],
      ),
    );
  }

  Container buildButtonCreateAccount() {
    return Container(
      width: screen,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle().darkColor),
        onPressed: () {
          print(
              'name = $name, typeUser = $typeUser, email = $email, password = $password');
          if ((name?.isEmpty ?? true) ||
              (email?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else if (typeUser == null) {
            normalDialog(context, 'No TypeUser', 'Please Choose Type User');
          } else {
            createAccountOnFirebase();
          }
        },
        child: Text('Create Account'),
      ),
    );
  }

  Future<Null> createAccountOnFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('Initialize Success');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await value.user.updateProfile(displayName: name);
        String uid = value.user.uid;
        // print('Create Account Success uid = $uid');

        UserModel model = UserModel(name: name, typeuser: typeUser);
        Map<String, dynamic> data = model.toMap();

        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(data)
            .then((value) {
          switch (typeUser) {
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
      }).catchError((res) {
        normalDialog(context, res.code, res.message);
      });
    });
  }

  Container buildBuyer() {
    return Container(
      width: screen * 0.5,
      child: RadioListTile(
        title: Text('Buyer'),
        value: 'buyer',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }

  Container buildShoper() {
    return Container(
      width: screen * 0.5,
      child: RadioListTile(
        title: Text('Shoper'),
        value: 'shoper',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }

  Container buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.5,
      child: Row(
        children: [
          MyStyle().titleH2('Type User :'),
        ],
      ),
    );
  }
}
