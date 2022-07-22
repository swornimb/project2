import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project2/models/JobDetails.dart';

Future<void> postData(mytitle, myprice, mydescription) async {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs.json');

  var response = await http.post(url,
      body: json.encode({
        "id": 'lfdsfds',
        "title": mytitle,
        "image":
            'https://cdn.pixabay.com/photo/2017/12/25/16/16/creativity-3038628_960_720.jpg',
        "price": myprice,
        "description": mydescription,
        "userid": 'u2'
      }));
}

Future <Map> getData() async {
  var url = Uri.parse(
    'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/add_jobs.json',
  );
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  Map jsonData = jsonDecode(response.body);
  return jsonData;
}
