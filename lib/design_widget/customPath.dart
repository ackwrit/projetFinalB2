// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


class CustomPath extends CustomClipper<Path>{
  var value;
  CustomPath({required var this.value});
  @override
  Path getClip(Size size) {
   
    Path path = Path();
    path.lineTo(0, size.height/4);
    path.cubicTo(size.width/4, size.height/4 + value, size.width/2, size.height/8 + value, size.width, size.height/8);
    path.lineTo(size.width, 0);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    
    return oldClipper is CustomPath && value!=oldClipper.value;
  }

}