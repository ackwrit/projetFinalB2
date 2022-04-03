// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetfinalb2/controller/chatController.dart';
import 'package:projetfinalb2/design_widget/backGround.dart';
import 'package:projetfinalb2/design_widget/drawer.dart';
import 'package:projetfinalb2/detail.dart';
import 'package:projetfinalb2/functions/firestoreHelper.dart';
import 'package:projetfinalb2/library/lib.dart';
import 'package:projetfinalb2/model/Utilisateur.dart';

class dashBoard extends StatefulWidget{
  const dashBoard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    
    return dashBoardState();
  }

}

class dashBoardState extends State<dashBoard>{
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();



  //Méthode de recherche élément dans une List
  bool recherche(value){
    return monProfil.contacts.contains(value);
  }




  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _globalKey,
      drawer: customDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: const EdgeInsets.only(left: 20),
          child:  InkWell(
            child: const FaIcon(FontAwesomeIcons.ellipsisVertical,color: Colors.black,),
            onTap: ()=>_globalKey.currentState!.openDrawer(),
          ),
        )

      ),
      extendBodyBehindAppBar: true,
      body: bodyPage(),
      backgroundColor: Colors.red,
    );
  }

  Widget bodyPage(){
    return Stack(
      children: [
        const backGround(),
        Center(
          child: Body(),
        ),

      ],
    );
  }


  Widget Body(){
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreHelper().fire_user.snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        else
        {
          List documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context,index){
              Utilisateur user = Utilisateur(documents[index]);
              if(user.id != monProfil.id){
                
                     return Card(
                elevation: 5.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child:  ListTile(
                title: Text("${user.prenom} ${user.nom}"),
                trailing: IconButton(
                  icon: recherche(user.id)?const FaIcon(FontAwesomeIcons.rocketchat):const FaIcon(FontAwesomeIcons.addressCard),
                  onPressed: (){
                    //Passage dans la messagerie
                    if(recherche(user.id)){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return chatController(monProfil, user);
                          }
                      ));


                    }
                    //Si c'est faux , icone ajouter contact + ajouter dans la base donnée
                    else
                      {
                        setState(() {
                          monProfil.contacts.add(user.id);
                          Map<String,dynamic> map ={
                            "CONTACTS":monProfil.contacts
                          };
                          firestoreHelper().updateUser(monProfil.id, map);

                        });

                      }


                  },
                  ),
                leading: Container(
                 height: 50,
                 width: 50,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     fit: BoxFit.fill,
                     image:(user.avatar!=null)?NetworkImage(user.avatar!):const NetworkImage("https://firebasestorage.googleapis.com/v0/b/projetfinalb2.appspot.com/o/inconnu.jpeg?alt=media&token=fe5ffbb2-f9fa-4a7a-bdc1-6a482817c9d4") 
                     )
                 ), 
                  ),

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context){
                      return Detail(user: user,);
                    }
                    ));
                },

              ),
              );
                
              }
              else {
                return Container();
              }
         
             
            }
            );
        }
      }
      );
  }


}