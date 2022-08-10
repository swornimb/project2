import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<void> postRegiterData(fullname, descriptionInput, location, email,
    selected, imageurl, uid,lon,lat) async {
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
        'uid': uid,
        'work':'',
        'wallet':'0',
        'lon':lon,
        'lat':lat
      })));
}

Future<Map> getDataRegister() async {
  final data = await http.get(Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers.json?orderBy="uid"&equalTo="${FirebaseAuth.instance.currentUser!.uid}"'));
  Map jsonDataRgister = jsonDecode(data.body);
  return jsonDataRgister;
}

Future<Map> getDataRegisterById(id) async {
  final data = await http.get(Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers.json?orderBy="uid"&equalTo="${id}"'));
  Map jsonDataRgister = jsonDecode(data.body);
  return jsonDataRgister;
}

putRegiterData(data, keye, money, jobname) async {

  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers/${keye}/.json');
  await (http.put(url,
      body: jsonEncode(<String, dynamic>{
        'key': keye,
        'name': data['name'],
        'description': data['description'],
        'email': data['email'],
        'location': data['location'],
        'skills': data['skills'],
        'imageurl': data['imageurl'],
        'uid': data['uid'],
        'wallet': (int.parse(data['wallet']) + int.parse(money)).toString(),
        'work': jobname+","+data['work'].toString(),
        'lat': data['lat'],
        'lon':data['lon']
      })));
}
putRegiterDataReduce(data, keye, money, jobname) async {

  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers/${keye}/.json');
  await (http.put(url,
      body: jsonEncode(<String, dynamic>{
        'key': keye,
        'name': data['name'],
        'description': data['description'],
        'email': data['email'],
        'location': data['location'],
        'skills': data['skills'],
        'imageurl': data['imageurl'],
        'uid': data['uid'],
        'wallet': (int.parse(data['wallet']) - int.parse(money)).toString(),
        'work': jobname+","+data['work'].toString(),
        'lat': data['lat'],
        'lon':data['lon']
      })));
}
loadmoney(data, keye, money) async {

  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers/${keye}/.json');
  await (http.put(url,
      body: jsonEncode(<String, dynamic>{
        'key': keye,
        'name': data['name'],
        'description': data['description'],
        'email': data['email'],
        'location': data['location'],
        'skills': data['skills'],
        'imageurl': data['imageurl'],
        'uid': data['uid'],
        'wallet': (int.parse(data['wallet']) + int.parse(money)).toString(),
        'work': data['work'].toString(),
        'lat': data['lat'],
        'lon':data['lon']
      })));
}

