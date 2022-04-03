import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utilisateur{
  late String id;
  late String nom;
  late String prenom;
  String? avatar;
  late String mail;
  DateTime? naissance;
  List contacts = [];


  Utilisateur(DocumentSnapshot snapshot){
    id = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    nom = map["NOM"];
    prenom = map["PRENOM"];
    avatar = map["AVATAR"];
    mail = map["MAIL"];
    Timestamp? timestamp = map["NAISSANCE"];
    naissance = timestamp?.toDate();
    contacts = map["CONTACTS"];
  }


  Map<String,dynamic> toMap()
  {
    Map <String,dynamic> map;
    return map ={
      'NOM':nom,
      'PRENOM':prenom,
      'AVATAR':avatar,
      'MAIL':mail,
      'NAISSANCE':naissance,
      "CONTACTS":contacts,


    };
  }
}