import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetfinalb2/design_widget/backGround.dart';
import 'package:projetfinalb2/library/lib.dart';
import 'package:projetfinalb2/model/Utilisateur.dart';

class Detail extends StatefulWidget{
  Utilisateur user;
  Detail({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
   
    return DetailState();
  }

}

class DetailState extends State<Detail>{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.explosion,color: Colors.black,), 
          onPressed: () {  
            Navigator.pop(context);
          },
          )
      ),
      backgroundColor: Colors.red,
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [
          const backGround(),
          Container(
            padding: const EdgeInsets.all(20),
            child: bodyPage(),
          )
          

        ],
      )
     
    );
  }



  Widget bodyPage(){
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: (widget.user.avatar!=null)?NetworkImage(widget.user.avatar!):const NetworkImage("https://firebasestorage.googleapis.com/v0/b/projetfinalb2.appspot.com/o/inconnu.jpeg?alt=media&token=fe5ffbb2-f9fa-4a7a-bdc1-6a482817c9d4"),
                
                )
              ),


          ),
          const SizedBox(height: 20,),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                         Text("${widget.user.prenom} ${widget.user.nom}"),
                const SizedBox(height: 20,),
                 Text(widget.user.mail),
          
                    ],
                  ),
            ),
          ),

           
        ],
        )
    );
    
  }

}