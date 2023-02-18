import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qstart_admin_web/Screens/ScreenMain.dart';

class loginController extends GetxController{
  var status=false.obs;

   //signin obscurepassword
  var obscurePassSignin = true.obs;

  TextEditingController loginemail= TextEditingController();
  TextEditingController loginpass=TextEditingController();
  //forget password
   TextEditingController resetEmail = TextEditingController();

  //create instance of firebase:
    //auth
   FirebaseAuth auth = FirebaseAuth.instance;
    //storage
   FirebaseFirestore db = FirebaseFirestore.instance;

//count complaint status
 var isdone=0.obs;
  var isverified=0.obs;
  var isDeclined=0.obs;
  var isProcessing=0.obs;
  var isRequested=0.obs;
  var isPending=0.obs;



   signin()async{
    try{
      status.value= true;
    await auth.signInWithEmailAndPassword(email: 'qstartoffical@gmail.com', password:'qstart12345');
    //check
    var value;
      var collection = FirebaseFirestore.instance.collection('Admin');
      var docSnapshot = await collection.doc('yG8Gj0ChhtblTTPym3q7').get();
      if (docSnapshot.exists) {
          Map<String, dynamic>? data = docSnapshot.data();
          value = data?['email']; // <-- The value you want to retrieve. 
  
      }
      if(value==loginemail.text){

      
      
      await countComplaintStatus();
      Get.offAll(ScreenMain());
      }
      else{
        print('value===');
        print(value);
        auth.signOut();
        Get.snackbar('Invalid email id', 'You are not a admin');
      }
      status.value=false;
    }
    catch(e){
      Get.snackbar("Error", "$e");
      status.value=false;
      print('working');
      print(e);
    }
  }

  //reset password
  resetpassword()async{
    try{
      await auth.sendPasswordResetEmail(email: resetEmail.text);
      Get.back();
      Get.snackbar("E-mail", "E-mail to reset password have been successfully send");
    }
    catch(e){
      Get.snackbar("Error", "$e");
    }
  }

  countComplaintStatus()async{
    //count
   isdone.value=0;
  isverified.value=0;
  isDeclined.value=0;
  isProcessing.value=0;
  isRequested.value=0;
  isPending.value=0;

    var collection = db.collection('complaint');
  var querySnapshot = await collection.get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    //each docs is accessed to data var on each iteration
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      
      //checking whether email id in docs on this iteration is equal to current user
      if(data['status']=='Requested'){
        isRequested.value++;
       }
       else if(data['status']=='Pending'){
          isPending.value++;
       }
       else if(data['status']=='Processing'){
          isProcessing.value++;
       }
       else if(data['status']=='Declined'){
          isDeclined.value++;
       }
       else if(data['status']=='Verified'){
          isverified.value++;
       }
       else if(data['status']=='Done'){
        isdone.value++;
       }
    }
  }

}