
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseServices{
  final String uid;
  DatabaseServices({required this.uid});

   Future updateUserDetails(String name, String age, String phone) async{
    return await FirebaseFirestore.instance.collection('users').doc(uid).set({
    'name': name,
    'age': age,
    'Phone Numbers': phone,
    });

  }


}