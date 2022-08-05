import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project2/logics/user_specific/post.dart';
import 'package:project2/models/JobDetails.dart';
import 'package:project2/screens/card_layout.dart';
import 'package:flutter/material.dart';

class UserSpecific extends StatelessWidget {
  List<JobDetails> specificList = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(title: Text("Your jobs")),
          body: FutureBuilder<Map>(
        future: getDataUserSpecific(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map? paylaod = snapshot.data;
            paylaod!.forEach((key, value) {
              specificList.add(JobDetails.fromjson(value));
            });
          }
          return CardLayout(specificList);
        },
      ),
          )
;
  }
}
