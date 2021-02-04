import 'package:flutter/material.dart';
import 'package:ungshopping/utility/my_style.dart';
import 'package:ungshopping/widget/body/information_shop.dart';
import 'package:ungshopping/widget/body/show_order.dart';
import 'package:ungshopping/widget/body/show_product.dart';

class ShoperService extends StatefulWidget {
  @override
  _ShoperServiceState createState() => _ShoperServiceState();
}

class _ShoperServiceState extends State<ShoperService> {
  Widget currentWidget = ShowOrder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoper Service'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuShowOrder(),
                buildMenuShowProduct(),
                buildMenuInformation(),
              ],
            ),
            MyStyle().buildSignOut(context),
          ],
        ),
      ),body: currentWidget,
    );
  }

  ListTile buildMenuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowOrder();
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.list),
      title: Text('Show Order'),
      subtitle: Text('แสดง Order ที่สั่งสินค้าเราไว้'),
    );
  }

  ListTile buildMenuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowProduct();
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.pets_rounded),
      title: Text('Show Product'),
      subtitle: Text('แสดง Product ของร้านเรา'),
    );
  }

  ListTile buildMenuInformation() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = InformationShop();
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.info),
      title: Text('Information Shop'),
      subtitle: Text('แสดง รายละเอียด ร้าน'),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Name'),
      accountEmail: Text('Shoper Type'),
    );
  }
}
