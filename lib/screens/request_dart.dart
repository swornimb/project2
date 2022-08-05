import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/logics/friend_request.dart/post.dart';
import 'package:project2/screens/friend-request-accepted.dart';
import 'package:project2/screens/friend-request-card.dart';

class RequestDetailsScreen extends StatefulWidget {
  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: Text("Job Requests"),
                bottom: TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.pending_actions),
                    text: "Request Jobs",
                  ),
                  Tab(
                    icon: Icon(Icons.done_all),
                    text: "Accepted",
                  )
                ]),
              ),
              body: TabBarView(children: [
                FutureBuilder<Map>(
                  future:
                      getfriendrequest(FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    Map? payload = snapshot.data;
                    List alldata = [];

                    payload!.forEach((key, value) {
                      Map zayload = {
                        'key': key.toString(),
                        'datakey': value['datakey'],
                        'userid': value['userid'],
                        'jobid': value['jobid'],
                        'requesterId': value['requesterId'],
                        'name': value['name'],
                        'jobname': value['jobname'],
                        'statue': value['status']
                      };
                      if (value['statue'] == 'pending') {
                        alldata.add(zayload);
                      }
                      ;
                    });
                    return FriendRequestCard(alldata);
                  },
                ),
                FutureBuilder<Map>(
                  future:
                      getfriendrequest(FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    Map? payload = snapshot.data;
                    List alldata = [];

                    payload!.forEach((key, value) {
                      Map zayload = {
                        'key': key.toString(),
                        'datakey': value['datakey'],
                        'userid': value['userid'],
                        'jobid': value['jobid'],
                        'requesterId': value['requesterId'],
                        'name': value['name'],
                        'jobname': value['jobname'],
                        'statue': value['status']
                      };
                      if (value['statue'] != 'pending') {
                        alldata.add(zayload);
                      }
                      ;
                    });
                    return FriendRequestAccpted(alldata);
                  },
                ),
              ])),
        ));
  }
}
