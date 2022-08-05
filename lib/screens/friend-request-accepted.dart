import 'package:flutter/material.dart';
import 'package:project2/logics/friend_request.dart/post.dart';

class FriendRequestAccpted extends StatelessWidget {
  List request = [];
  FriendRequestAccpted(this.request);

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
                  ],
                ),
              )
            ]),
          );
        });
  }
}
