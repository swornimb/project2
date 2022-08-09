import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/logics/friend_request.dart/post.dart';
import 'package:project2/logics/jobs/post.dart';
import 'package:project2/logics/register/post.dart';
import 'package:project2/models/JobDetails.dart';
import 'package:http/http.dart' as http;

class JobDescription extends StatefulWidget {
  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  String? myname;
  String? keyy;
  Map? selectedjob = {"a": "b"};

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
                onTap: () async {
                  Map payload = await getDataRegisterById(routsArgs.userid);
                  Navigator.of(context).pushNamed('./screens/user-details',
                      arguments: payload);
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
            FutureBuilder<Map>(
                future: requestStatus(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map payload = snapshot.data as Map;
                    payload.forEach(
                      (key, value) {
                        if (routsArgs.id == value['jobid']) {
                          selectedjob = value;
                        }
                      },
                    );
                    if (selectedjob!.containsValue("pending")) {
                      return Text(
                        "Request Pending",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    } else if (selectedjob!.containsValue("Accepted")) {
                      return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async {
                              putfriendrequestCompleted(selectedjob);
                              Map alldata = await getDataRegister();
                              Map payment = await getDataSpecific(routsArgs.id);
                              alldata.forEach((key1, value1) {
                                payment.forEach(
                                  (key, value) {
                                    putRegiterData(value1, key1.toString(),
                                        value['price'], value['title']);
                                  },
                                );
                              });
                              Map alldata2 =
                                  await getDataRegisterById(routsArgs.userid);
                              Map payment2 =
                                  await getDataSpecific(routsArgs.id);
                              alldata2.forEach((key1, value1) {
                                payment2.forEach(
                                  (key, value) {
                                    putRegiterDataReduce(
                                        value1,
                                        key1.toString(),
                                        value['price'],
                                        value['title']);
                                  },
                                );
                              });
                            },
                            child: Text("Completed"),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                primary: Colors.white,
                                backgroundColor: Colors.blue),
                          ));
                    } else {
                      return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async {
                              var url = Uri.parse(
                                  'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers.json?orderBy="uid"&equalTo="${FirebaseAuth.instance.currentUser!.uid}"');
                              var data = await http.get(url);
                              Map payload = jsonDecode(data.body);

                              payload.forEach((key, value) {
                                setState(() {
                                  keyy = key.toString();
                                  myname = value['name'];
                                });
                              });
                              Map alldata = {
                                'datakey': keyy,
                                'userid': routsArgs.userid,
                                'jobid': routsArgs.id,
                                'requesterId':
                                    FirebaseAuth.instance.currentUser!.uid,
                                'name': myname,
                                'jobname': routsArgs.title,
                                'statue': 'pending'
                              };
                              friendRequestpost(alldata);
                            },
                            child: Text("Apply Job"),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                primary: Colors.white,
                                backgroundColor: Colors.blue),
                          ));
                    }
                  } else {
                    return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () async {
                            var url = Uri.parse(
                                'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/registers.json?orderBy="uid"&equalTo="${FirebaseAuth.instance.currentUser!.uid}"');
                            var data = await http.get(url);
                            Map payload = jsonDecode(data.body);

                            payload.forEach((key, value) {
                              setState(() {
                                keyy = key.toString();
                                myname = value['name'];
                              });
                            });
                            Map alldata = {
                              'datakey': keyy,
                              'userid': routsArgs.userid,
                              'jobid': routsArgs.id,
                              'requesterId':
                                  FirebaseAuth.instance.currentUser!.uid,
                              'name': myname,
                              'jobname': routsArgs.title,
                              'statue': 'pending'
                            };
                            friendRequestpost(alldata);
                          },
                          child: Text("Apply Job"),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              primary: Colors.white,
                              backgroundColor: Colors.blue),
                        ));
                  }
                })
          ],
        ),
      )),
    );
  }
}
