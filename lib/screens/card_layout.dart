import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/logics/jobs/post.dart';
import 'package:project2/logics/user_specific/post.dart';
import 'package:project2/models/JobDetails.dart';
import '../datas/user_list.dart';
import 'package:http/http.dart' as http;

class CardLayout extends StatefulWidget {
  List<JobDetails> joblist = [];
  CardLayout(this.joblist);

  @override
  State<CardLayout> createState() => _CardLayoutState();
}

class _CardLayoutState extends State<CardLayout> {
  void selectedJob(BuildContext ctx, JobDetails data) async {
    Navigator.of(ctx).pushNamed('./job-description', arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.joblist.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: InkWell(
            onTap: () => selectedJob(context, widget.joblist[index]),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      widget.joblist[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                widget.joblist[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              margin: EdgeInsets.all(5),
                            ),
                            FirebaseAuth.instance.currentUser!.uid ==
                                    widget.joblist[index].userid
                                ? Row(children: [
                                    InkWell(
                                      child: Icon(Icons.edit),
                                      onTap: () async {
                                        Map payload = await getDataSpecific(
                                            widget.joblist[index].id);
                                        print(payload);
                                        Navigator.pushNamed(
                                            context, './foredit',
                                            arguments: payload);
                                      },
                                    ),
                                    InkWell(
                                      onTap: (() async {
                                        Map payload = await getDataSpecific(
                                            widget.joblist[index].id);
                                        payload.forEach((key, value) =>
                                            deleteData(key));
                                      }),
                                      child: Icon(Icons.delete),
                                    )
                                  ])
                                : Text(" "),
                          ],
                        ),
                        Container(
                            child: Row(children: [
                              Icon(
                                Icons.currency_rupee,
                                color: Theme.of(context).primaryColor,
                                size: 12,
                              ),
                              Text(
                                widget.joblist[index].price.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.blue),
                              )
                            ]),
                            margin: EdgeInsets.all(5)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
