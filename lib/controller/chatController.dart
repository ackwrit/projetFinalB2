

import 'package:flutter/material.dart';
import 'package:projetfinalb2/controller/messageController.dart';
import 'package:projetfinalb2/design_widget/backGround.dart';
import 'package:projetfinalb2/design_widget/zoneText.dart';
import 'package:projetfinalb2/model/Utilisateur.dart';

class chatController extends StatefulWidget{
  Utilisateur moi;
  Utilisateur partenaire;
  chatController(@required this.moi,@required this.partenaire);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return chatControllerState();
  }

}
class chatControllerState extends State<chatController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("${widget.partenaire.prenom} ${widget.partenaire.nom}",style: TextStyle(color: Colors.white),),

      ),
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          backGround(),
          bodyPage(),
        ],
      )

    );
  }




  Widget bodyPage(){
    print('ody messagerie');
    print(widget.moi.id);
    print(widget.partenaire.id);
    return Container(
      child: InkWell(
        onTap: ()=>FocusScope.of(context).requestFocus(new FocusNode()),
        child: Column(
          children: [
            //Zone de chat
            new Flexible(child: Container(
              height: MediaQuery.of(context).size.height,
              child: Messagecontroller(widget.moi,widget.partenaire),
            )),
            //Divider
            new Divider(height: 1.5,),
            //Zone de text
            ZoneText(widget.partenaire,widget.moi),
          ],
        ),
      ),
    );
  }

}