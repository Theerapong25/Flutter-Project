import 'package:final_project/model/fooddetail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Formsreen extends StatefulWidget {
  const Formsreen({super.key});

  @override
  State<Formsreen> createState() => _FormsreenState();
}
class _FormsreenState extends State<Formsreen> {
FoodDetailScreen foodDetailScreen = FoodDetailScreen();
final formkey = GlobalKey<FormState>();
final Future<FirebaseApp> firebase = Firebase.initializeApp();
CollectionReference _foodCollection = FirebaseFirestore.instance.collection('ListFood');

  @override
  Widget build(BuildContext context){
    return Scaffold (
           appBar:  AppBar(title: Text('เพิ่มข้อมูลรายการ'),
           ),
           body: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formkey,
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ชื่อ'),
                  TextFormField(
                    onSaved: (String? name){
                      foodDetailScreen.name = name;
                    }
                  ),
                  SizedBox(height: 10,),
                  Text('วัตถุดิบ'),
                  TextFormField(onSaved: (String? ingredients){
                      foodDetailScreen.ingredients = ingredients;
                    }),
                  SizedBox(height: 10,),
                  Text('วิธีทำ'),
                  TextFormField(onSaved: (String? method){
                      foodDetailScreen.method = method;
                    }),
                  SizedBox(height: 10,),
                  Text('kcel'),
                  TextFormField(onSaved: (String? kcal){
                      foodDetailScreen.kcal = kcal;
                    }),
                    SizedBox(height: 10,),
                  Text('รูปภาพ'),
                  TextFormField(onSaved: (String? image){
                      foodDetailScreen.image = image;
                    }),
                  SizedBox(child: ElevatedButton(
                    onPressed: ()async {
                            formkey.currentState!.save();
                           await _foodCollection.add({
                              "name":foodDetailScreen.name,
                              "ingredients":foodDetailScreen.ingredients,
                              "method":foodDetailScreen.method,
                              "kcal":foodDetailScreen.kcal,
                              "image":foodDetailScreen.image

                            });
                            formkey.currentState!.reset();

                  }, child: Text('บันทึกข้อมูล')),
                  ),
                
                ],
                            ),
              )),
           ),
    );
  }
  }
