import 'package:flutter/material.dart';
import 'dimensoins.dart';


class ResponsiveLayout extends StatelessWidget {
  final Widget mobilebody;
  final Widget desktopbody;
  final Widget maxbody;

  ResponsiveLayout({required this.mobilebody, required this.desktopbody,required this.maxbody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileWidth) {
        return mobilebody;
      } else if(constraints.maxWidth > mobileWidth && constraints.maxWidth < desktopWidth){
        return desktopbody;
      }else{
        return maxbody;
      }
    },
    );
  }
}