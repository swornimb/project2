import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:project2/logics/user_specific/post.dart';
import 'package:project2/models/JobDetails.dart';
import 'package:project2/screens/card_layout.dart';

class UserDetails extends StatelessWidget {
  List<JobDetails> userjob = [];
  @override
  Widget build(BuildContext context) {
    Map dataArgs = ModalRoute.of(context)?.settings.arguments as Map;
    List x = dataArgs.values.toList();
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("User Details"), actions: [
          IconButton(
              onPressed: ()  {
                  Navigator.pushNamed(context, './userFuture',
                      arguments: userjob);
              },
              icon: Icon(Icons.list)),
          IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed('./screens/job-request');
              }),
        ]),
        body: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(x[0]['imageurl'])),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text("Description",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  Text(
                    x[0]['description'],
                    style: TextStyle(color: Colors.black54, height: 1.5),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text("Skills",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var i in x[0]['skills'])
                        Badge(
                          badgeContent: Text(
                            i,
                            style: TextStyle(color: Colors.white),
                          ),
                          badgeColor: Colors.blue,
                          shape: BadgeShape.square,
                          borderRadius: BorderRadius.circular(5),
                        ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Projcts Done",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  // Wrap(
                  //   spacing: 10,
                  //   runSpacing: 10,
                  //   children: [
                  //     for(var i in myuserid.user_work)
                  //     Badge(
                  //       badgeContent: Wrap(
                  //         children: [
                  //           Badge(
                  //             shape: BadgeShape.circle,
                  //             badgeContent: Text(i['count']),
                  //             padding: EdgeInsets.all(10),
                  //           ),
                  //           Container(
                  //             child: Text(i['job']),
                  //             margin: EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //           )
                  //         ],
                  //         alignment: WrapAlignment.center,
                  //       ),
                  //       badgeColor: Colors.blue,
                  //       shape: BadgeShape.square,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
