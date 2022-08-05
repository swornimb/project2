import 'package:flutter/material.dart';
import 'package:project2/logics/friend_request.dart/post.dart';

class FriendRequestCard extends StatelessWidget {
  List request = [];
  FriendRequestCard(this.request);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: request.length,
        itemBuilder: (BuildContext context, index) {
          print(request[index]['statue']);
          return Card(
            child: Column(children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              request[index]['name'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(request[index]['jobname']),
                          ),
                        ],
                      ),
                    ),
                        Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: TextButton(
                                      onPressed: () {
                                        print(request[index]['statue']);
                                        putfriendrequestAccept(request[index]);
                                      },
                                      child: Text("Accept"),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 10)),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)))),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: TextButton(
                                    onPressed: () {
                                      putfriendrequestReject(request[index]);
                                    },
                                    child: Text("Reject"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10)),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white))),
                              )
                            ],
                          )
                  ],
                ),
              )
            ]),
          );
        });
  }
}
