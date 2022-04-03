
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:projetfinalb2/design_widget/arcPath.dart';
import 'package:projetfinalb2/design_widget/customPath.dart';

class backGround extends StatefulWidget{
  const backGround({Key? key}) : super(key: key);

  @override
  State<backGround> createState() => _backGroundState();
}

class _backGroundState extends State<backGround> {
  @override
  Widget build(BuildContext context) {
    
    return Stack(
        children: [
          TweenAnimationBuilder<double>(
              tween: Tween(begin: -50,end:0),
              curve: Curves.elasticOut,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image_fond.jpg"),
                    fit: BoxFit.fill
                  )
                ),
              ),
              duration: const Duration(seconds: 4),
              builder: (ctx,value,child){
                return ClipPath(
                  clipper: arcPath(value:value),
                  child: child,
                );
              }
          ),
          TweenAnimationBuilder<double>(
            curve: Curves.elasticInOut,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.red,
            ),
            tween: Tween(begin: -50,end: 0), 
            duration: const Duration(seconds: 4), 
            builder: (context,value,child){
              return    ClipPath(
            clipper: CustomPath(value:value),
            
            child: child
          );

            }
            
            )

       




        ],

    );


  }
}


