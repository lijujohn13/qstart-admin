import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class userController extends GetxController{

  TextEditingController searchbar= TextEditingController();
  //firebase firestore instance
  FirebaseFirestore db=FirebaseFirestore.instance;

   late Map<String, dynamic> query;
  //search functions
  search(String value){
   return db.collection('users').where("username",isLessThanOrEqualTo: value).get();
  }
}