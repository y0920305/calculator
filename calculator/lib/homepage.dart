import 'package:calculator/responsive/desktop_body.dart';
import 'package:calculator/responsive/max_body.dart';
import 'package:calculator/responsive/mobile_body.dart';
import 'package:calculator/responsive/responsive_layout.dart';
import 'package:calculator/responsive/test.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  @override
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobilebody: MyMobileBody(),
        desktopbody: MyDesktopBody(),
        maxbody: MyMaxBody(),
      ),
    );
  }
}
