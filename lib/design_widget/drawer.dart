import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetfinalb2/functions/firestoreHelper.dart';
import 'package:projetfinalb2/library/constant.dart';
import 'package:file_picker/file_picker.dart';

class customDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return customDrawerState();
  }

}

class customDrawerState extends State<customDrawer>{
  Uint8List? bytesData;
  String? chemeinUrl;
  String? nameFile;



  picker() async{
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if(filePickerResult!=null){
      setState(() {
        bytesData = filePickerResult.files.first.bytes;
        nameFile = filePickerResult.files.first.name;
        if(bytesData != null){
          Showdialog();
        }
      });

    }
  }

  Showdialog(){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
          if(Platform.isIOS){
            return CupertinoAlertDialog(
              title: Text("Souhaiter enregistrer cette image ?"),
              content: Image.memory(bytesData!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Annuler")
                ),
                ElevatedButton(
                    onPressed: (){
                      firestoreHelper().stockageImage(nameFile!, bytesData!).then((value){
                        setState(() {
                          chemeinUrl = value;
                          Map<String,dynamic> map ={
                            "AVATAR":chemeinUrl,
                          };
                          monProfil.avatar = chemeinUrl;
                          firestoreHelper().updateUser(monProfil.id, map);
                          Navigator.pop(context);
                        });




                      });

                    },
                    child: Text("Ok")
                ),
              ],
            );
          }
          else
            {
              return AlertDialog();
            }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width/1.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4,
            color: Colors.red,
            child: Banniere(),
          ),
          SizedBox(height: 20,),
          Text("${monProfil.prenom} ${monProfil.nom}"),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings),
              SizedBox(width: 10,),
              Text("Paramètres")
            ],
          ),

          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket)
          ),


        ],
      ),
    );
  }


  Widget Banniere(){
    return Column(
      children: [
        SizedBox(height: 20,),
        InkWell(
          child: Container(

            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: (monProfil.avatar!=null)?NetworkImage(monProfil.avatar!):NetworkImage("https://firebasestorage.googleapis.com/v0/b/projetfinalb2.appspot.com/o/inconnu.jpeg?alt=media&token=fe5ffbb2-f9fa-4a7a-bdc1-6a482817c9d4"),
                    fit: BoxFit.fill
                )
            ),
          ),
          onTap: (){
            picker();


          },
        ),

        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            FaIcon(FontAwesomeIcons.envelope),
            SizedBox(width: 10,),
            Text(monProfil.mail)
          ],
        )

      ],
    );
  }

}