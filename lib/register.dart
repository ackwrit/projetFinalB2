import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:projetfinalb2/authentification.dart';
import 'package:projetfinalb2/dashboard.dart';
import 'package:projetfinalb2/design_widget/arcPath.dart';
import 'package:projetfinalb2/design_widget/backGround.dart';
import 'package:projetfinalb2/functions/firestoreHelper.dart';
import 'package:projetfinalb2/library/constant.dart';

class register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registerState();
  }

}

class registerState extends State<register>{
  late String mail;
  late String password;
  late String nom;
  late String prenom;
  late ConfettiController confettiController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confettiController = ConfettiController(
      duration: Duration(seconds: 10),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    confettiController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          backGround(),

          Container(
            child: bodypage(),
            padding: EdgeInsets.all(20),
          ),
          ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.05,
            shouldLoop: true,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),


        ],
      ),



      
    );
  }



  Widget bodypage(){
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
              prefixIcon:  Icon(Icons.mail),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value){
              setState(() {
                mail = value;
              });
            },
          ),
          SizedBox(height: 10,),
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
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              hintText: "Entrer votre nom",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon:  Icon(Icons.person),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value){
              setState(() {
                nom = value;
              });
            },
          ),
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              hintText: "Entrer votre prénom",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon:  Icon(Icons.person),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value){
              setState(() {
                prenom = value;
              });
            },
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  primary: Colors.red
              ),
              onPressed: (){
                firestoreHelper().inscription(mail, password, nom, prenom).then((value){
                  setState(() {
                    monProfil = value;
                  });
                  //Ajouter confetti
                  print("Unity");
                  confettiController.play();
                  print("passage");

                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return dashBoard();
                      }
                  ));

                }).catchError((onError){
                  print(onError);

                });


              },
              child: Text("Inscription")
          ),
          SizedBox(height: 10,),
          InkWell(
            child: Text("Connexion",style: TextStyle(color: Colors.blue),),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                  fullscreenDialog: true,

                  builder: (context){
                    return authentification();
                  }
              ));

            },
          ),





        ],
      ),
    );
  }

}