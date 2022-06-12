import 'package:flutter/material.dart';
import 'package:project2/job_description.dart';
import 'package:project2/request_dart.dart';
import './card_layout.dart';
import './data_list.dart';
import './user_details.dart';
import './opening_form.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

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
            UserForm(),
            Container(
              child: ListView.builder(
                itemCount: JobList.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child:CardLayout(id: JobList[index].id,title: JobList[index].title, price: JobList[index].price, imagelink: JobList[index].image, description: JobList[index].description,),
                  );
                },
              ),
            ),
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
        './job-description':(ctx)=>JobDescription()
      },
    );
  }
}

