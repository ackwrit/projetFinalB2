import 'package:flutter/material.dart';

class arcPath extends CustomClipper<Path>{
  var value;
  arcPath({required var this.value});
  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    Path path = Path();

   path.lineTo(0, size.height);
   path.lineTo(size.width-(size.width/4), size.height);
   path.quadraticBezierTo(size.width-(size.width/4)+value, size.height-(size.height/8) + value, size.width, (size.height-size.height/8)+value);
   path.lineTo(size.width, 0);


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  
    return oldClipper is arcPath && value!=oldClipper.value;
  }

}