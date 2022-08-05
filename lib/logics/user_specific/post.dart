import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

var data = FirebaseAuth.instance.currentUser!.uid;

Future<Map> getDataUserSpecific() async{
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs.json?orderBy="userid"&equalTo="${data}"');

  var payload = await http.get(url);
  return jsonDecode(payload.body);
}
