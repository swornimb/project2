import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<void> postRegiterData(fullname, descriptionInput, location, email,
    selected, imageurl, uid) async {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers.json');
  await (http.post(url,
      body: jsonEncode(<String, dynamic>{
        'name': fullname,
        'description': descriptionInput,
        'email': email,
        'location': location,
        'skills': selected,
        'imageurl': imageurl,
        'uid': uid
      })));
}

Future<Map> getDataRegister() async {
  final data = await http.get(Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers.json?uid=${FirebaseAuth.instance.currentUser!.uid}'));
  Map jsonDataRgister = jsonDecode(data.body);
  return jsonDataRgister;
}
