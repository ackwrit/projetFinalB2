
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projetfinalb2/model/Utilisateur.dart';


class firestoreHelper{
  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection("Users");
  final fire_message = FirebaseFirestore.instance.collection("Message");
  final fire_conversation=FirebaseFirestore.instance.collection('Conversations');



  Future <Utilisateur> inscription(String mail, String password, String nom, String prenom) async{
    UserCredential result = await auth.createUserWithEmailAndPassword(email: mail, password: password);
    List<String> tableau = [];
    User user = result.user!;
    String uid = user.uid;
    Map<String,dynamic> map = {
      "NOM":nom,
      "PRENOM":prenom,
      "MAIL":mail,
      "CONTACT": tableau
    };
    addUser(uid, map);
    return getUser(uid);

  }
  
  
  Future<Utilisateur> connect(String mail,String password) async{
    UserCredential result = await auth.signInWithEmailAndPassword(email: mail, password: password);
    User user = result.user!;
    String uid = user.uid;
    return getUser(uid);
  }
  
  
  addUser(String uid, Map<String,dynamic>map){
    fire_user.doc(uid).set(map);
  }

  updateUser(String uid, Map<String,dynamic>map){
    fire_user.doc(uid).update(map);
  }
  
  Future <String> getIdentifiant() async {
    return auth.currentUser!.uid;
  }


  
  Future <Utilisateur> getUser(String uid) async {
    DocumentSnapshot snapshot = await fire_user.doc(uid).get();
    return Utilisateur(snapshot);
  }


Future <String> stockageImage(String uid,Uint8List datas) async {
    TaskSnapshot snap = await FirebaseStorage.instance.ref("images/$uid").putData(datas);
    String chemin = await snap.ref.getDownloadURL();
    return chemin;

}


  sendMessage(String texte,Utilisateur user,Utilisateur moi){
    DateTime date=DateTime.now();
    Map <String,dynamic>map={
      'from':moi.id,
      'to':user.id,
      'texte':texte,
      'envoiMessage':date
    };

    String idDate = date.microsecondsSinceEpoch.toString();

    addMessage(map, getMessageRef(moi.id, user.id, idDate));

    addConversation(getConversation(moi.id, user, texte, date), moi.id);

    addConversation(getConversation(user.id, moi, texte, date), user.id);




  }

  Map <String,dynamic> getConversation(String sender,Utilisateur partenaire,String texte,DateTime date){
    Map <String,dynamic> map = partenaire.toMap();
    map ['idmoi']=sender;
    map['lastmessage']=texte;
    map['envoimessage']=date;
    map['destinateur']=partenaire.id;

    return map;

  }


  String getMessageRef(String from,String to,String date){
    String resultat="";
    List<String> liste=[from,to];
    liste.sort((a,b)=>a.compareTo(b));
    for(var x in liste){
      resultat += x+"+";
    }
    resultat =resultat + date;
    return resultat;

  }



  addMessage(Map<String,dynamic> map,String uid){
    fire_message.doc(uid).set(map);

  }

  addConversation(Map<String,dynamic> map,String uid){
    fire_conversation.doc(uid).set(map);

  }





}