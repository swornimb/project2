import 'package:flutter/material.dart';
import 'package:project2/job_description.dart';
import 'package:project2/request_dart.dart';
import './card_layout.dart';
import './data_list.dart';
import './user_details.dart';
import './opening_form.dart';
import 'JobDetails.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: UserDetails(),
      home: DefaultTabController(
        length:2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Project 2"),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add), text: "Add Job",),
                Tab(icon: Icon(Icons.list),text: "Job List",)
              ],
            ),
          ),

          body: TabBarView(
          children: [
            UserForm(
                (mytitle, myprice, mydescription){
                  setState(() {
                    JobList.add(JobDetails(id: 'l${JobList.length+1}', title: mytitle, image:'https://cdn.pixabay.com/photo/2017/12/25/16/16/creativity-3038628_960_720.jpg', price: myprice , description: mydescription));

                  });
                }
            ),
            CardLayout(JobList)
          ],
          )

        ),
      ),
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      routes:{
        './job-description':(ctx)=>JobDescription(),
        './user-details':(ctx)=>UserDetails(),
        './job-request':(ctx)=>RequestDetailsScreen(),
      },
    );
  }
}

