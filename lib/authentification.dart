// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:projetfinalb2/dashboard.dart';
import 'package:projetfinalb2/design_widget/backGround.dart';
import 'package:projetfinalb2/functions/firestoreHelper.dart';
import 'package:projetfinalb2/library/constant.dart';
import 'package:projetfinalb2/register.dart';

class authentification extends StatefulWidget{
  const authentification({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return authentificationState();
  }

}

class authentificationState extends State<authentification>{
  late String mail;
  late String password;
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.red,

      body: Stack(
        children: [
          backGround(),
          Container(
            child:  bodyPage(),
            padding: const EdgeInsets.all(20),
          )
         
        ],
      )


    );
  }


  Widget bodyPage(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Entrer votre adresse mail",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon:  const Icon(Icons.mail),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value){
              setState(() {
                mail = value;
              });
            },
          ),
          const SizedBox(height: 10,),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Entrer votre mot de passe",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon:  Icon(Icons.lock),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value){
              setState(() {
                password = value;
              });
            },
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              primary: Colors.red
            ),
              onPressed: (){
              firestoreHelper().connect(mail, password).then((value){
                setState(() {
                  monProfil = value;
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return dashBoard();
                      }
                  ));
                });

              }).catchError((onError){

              });


              },
              child: const Text("Connexion")
          ),
          SizedBox(height: 10,),
          InkWell(
            child: const Text("Inscription",style: TextStyle(color: Colors.blue),),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                fullscreenDialog: true,

                  builder: (context){
                    return register();
                  }
              ));

            },
          ),





        ],
      ),
    );
  }

}
