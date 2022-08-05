import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/logics/friend_request.dart/post.dart';
import 'package:project2/models/JobDetails.dart';
import '../datas/jobs_list.dart';
import '../datas/user_list.dart';
import 'package:http/http.dart' as http;

class JobDescription extends StatefulWidget {
  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  String? myname;
  String? keyy;

  @override
  Widget build(BuildContext context) {
    JobDetails routsArgs =
        ModalRoute.of(context)?.settings.arguments as JobDetails;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Image.network(
                    routsArgs.image,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(routsArgs.title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Text(routsArgs.userid),
                  onTap: () {
                    Navigator.of(context).pushNamed('./screens/user-details',
                        arguments: {'userid': routsArgs.userid});
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  routsArgs.description,
                  style: TextStyle(color: Colors.black54, height: 1.5),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () async {
                    var url = Uri.parse(
                        'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers.json?orderBy="uid"&equalTo="${FirebaseAuth.instance.currentUser!.uid}"');
                    var data = await http.get(url);
                    Map payload = jsonDecode(data.body);

                    payload.forEach((key, value) {
                      print(value['name']);
                      setState(() {
                        keyy = key.toString();
                        myname = value['name'];
                      });
                    });
                    Map alldata = {
                      'datakey': keyy,
                      'userid': routsArgs.userid,
                      'jobid': routsArgs.id,
                      'requesterId': FirebaseAuth.instance.currentUser!.uid,
                      'name': myname,
                      'jobname': routsArgs.title,
                      'statue': 'pending'
                    };
                    friendRequestpost(alldata);
                  },
                  child: Text("Apply Job"),
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      primary: Colors.white,
                      backgroundColor: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
