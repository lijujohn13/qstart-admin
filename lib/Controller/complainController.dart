import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qstart_admin_web/Controller/loginController.dart';

class ComplaintContoller extends GetxController {
//firestore instance
  FirebaseFirestore db = FirebaseFirestore.instance;

//create instance of logincontroller
  final ctrl = Get.put(loginController());

//loading
  var loading = false.obs;

//decline description controller
  TextEditingController declineDescription = TextEditingController();

//Accept work and assign it to a user
  AcceptandAssign(var complaintid, var workerid,var workerdocid) async {
    try {
      loading.value = true;
      //update worderid field in complaint table
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"workerid": workerid});
      //change status of complaint to accepted
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"status": 'Processing'});
      //update total complaint field in worker table

      // Map<String, dynamic> profiledata = Workerprofiledetails(workerid);

      db.collection('worker').doc(workerdocid).update({"totalcomplaintcount": FieldValue.increment(1)});
      
      //count complaint status for home screen
      ctrl.countComplaintStatus();
      loading.value = false;
    } catch (e) {
      Get.snackbar('Error', '$e');
      loading.value = false;
    }
  }

//Decline work
  DeclineWork(var complaintid) async {
    try {
      loading.value = true;
      //update status
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"status": 'Declined'});
      //update decline message field in complaint table
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"declinemsg": declineDescription.text});
      //update count of complaint in dashboard
      ctrl.countComplaintStatus();
      //clear declinedescription controller
      declineDescription.clear();
      loading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Unable to update');
      loading.value = false;
    }
  }

  //Done Verified
  DoneVerified(var complaintid, var userid) async {
    try {
      loading.value = true;
      //update status
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"status": 'Verified'});

      //update done count in user table
      var docs;
      var collection = db.collection('users');
      var querySnapshot = await collection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        //each docs is accessed to data var on each iteration
        Map<String, dynamic> data = queryDocumentSnapshot.data();

        //checking whether email id in docs on this iteration is equal to current user
        if (data['id'] == userid) {
          docs = queryDocumentSnapshot.id;
          break;
        }
      }
      print(docs);
         db .collection('users')
          .doc(docs)
          .update({"donecount": FieldValue.increment(1)});
      //
      //update count of complaint in dashboard
      ctrl.countComplaintStatus();

      loading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Unable to update');
      loading.value = false;
    }
  }

  //access worker table and return
  //get data
  Workerprofiledetails(var workerid) async {
    var collection = db.collection('users');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      //each docs is accessed to data var on each iteration
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      //checking whether email id in docs on this iteration is equal to current user
      if (data['id'] == workerid.toString()) {
        return data;
      }
    }
  }
}
