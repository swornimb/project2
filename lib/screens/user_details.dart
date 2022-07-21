import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import '../datas/user_list.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    var userid = dataArgs['userid'];
    var myuserid = UserDatas.firstWhere((element) => userid == element.user_id);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("User Details"), actions: [
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
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png')),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(myuserid.user_name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  Text(
                    myuserid.user_bio,
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
                      for (var i in myuserid.user_skills)
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
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for(var i in myuserid.user_work)
                      Badge(
                        badgeContent: Wrap(
                          children: [
                            Badge(
                              shape: BadgeShape.circle,
                              badgeContent: Text(i['count']),
                              padding: EdgeInsets.all(10),
                            ),
                            Container(
                              child: Text(i['job']),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                            )
                          ],
                          alignment: WrapAlignment.center,
                        ),
                        badgeColor: Colors.blue,
                        shape: BadgeShape.square,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
