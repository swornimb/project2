import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project2/models/JobDetails.dart';

Future<void> postData(id, mytitle, myprice, mydescription,location, latitude, longitude) async {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs.json');

  var response = await http.post(url,
      body: json.encode({
        "id": id,
        "title": mytitle,
        "image":
            'https://cdn.pixabay.com/photo/2017/12/25/16/16/creativity-3038628_960_720.jpg',
        "price": myprice,
        "description": mydescription,
        "userid": FirebaseAuth.instance.currentUser!.uid,
        'location': location,
        "lat":latitude,
        'lon': longitude,
        
      }));
}

Future<Map> getData() async {
  var url = Uri.parse(
    'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs.json',
  );
  var response = await http.get(url);
  Map jsonData = jsonDecode(response.body);
  return jsonData;
}

Future<Map> getDataSpecific(id) async {
  var url = Uri.parse(
    'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs.json?orderBy="id"&equalTo="${id}"',
  );
  var response = await http.get(url);
  Map payload = jsonDecode(response.body);
  return payload;
}


Future<void> putData(id, mytitle, myprice, mydescription, keyy, location, lat, lon, userid) async {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs/${keyy}/.json');
  var response = await http.patch(url,
      body: jsonEncode({
        "title": mytitle,
        "price": myprice,
        "description": mydescription,
        'id':id,
        'location':location,
        'lat':lat,
        'lon':lon,
        'userid':userid
      }));
  print(response.body);
}

deleteData(id) async {
  var url = Uri.parse(
    'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs/${id.toString()}.json?x-http-method-override=DELETE',
  );
  var response = await http.delete(url);
}
