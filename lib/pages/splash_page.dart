import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState

    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    // Navigator.pushNamed(context, '/sign-in');
    Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Container(
        color: Color(0xFFe19ee8),
        child: Center(
            child: Text(
          'Shop App Template',
          style: whiteTextStyle.copyWith(fontSize: 32),
        )),
      ),
      
    );
  }
}
