import 'package:flutter/material.dart';
import 'package:ungshopping/widget/authen.dart';
import 'package:ungshopping/widget/buyer_service.dart';
import 'package:ungshopping/widget/create_account.dart';
import 'package:ungshopping/widget/shoper_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccoun(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/shoperService': (BuildContext context) => ShoperService(),
};
