
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetfinalb2/design_widget/messageBubble.dart';
import 'package:projetfinalb2/functions/firestoreHelper.dart';
import 'package:projetfinalb2/model/Message.dart';
import 'package:projetfinalb2/model/Utilisateur.dart';

class Messagecontroller extends StatefulWidget{
  Utilisateur id;
  Utilisateur idPartner;
  Messagecontroller(@required Utilisateur this.id,@required Utilisateur this.idPartner);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessagecontrollerState();
  }

}

class MessagecontrollerState extends State<Messagecontroller> with SingleTickerProviderStateMixin{
  late Animation animation;
  late AnimationController controller;

  @override
  void initState() {
    
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
  

    )..repeat();
    animation = Tween<double>(begin: 10,end: 20).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
        stream: firestoreHelper().fire_message.orderBy('envoiMessage',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          else {
            List<DocumentSnapshot>documents = snapshot.data!.docs;

            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext ctx,int index)
                {
                  Message discussion = Message(documents[index]);
                  if((discussion.from==widget.id.id && discussion.to==widget.idPartner.id)||(discussion.from==widget.idPartner.id&&discussion.to==widget.id.id))
                  {

                    return messageBubble(widget.id.id, widget.idPartner, discussion,animation: animation,);
                  }
                  else
                  {
                    return Container();
                  }

                }
            );


          }
        }
    );
  }
}