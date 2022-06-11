import 'package:flutter/material.dart';
import 'package:project2/job_description.dart';
import './card_layout.dart';
import './data_list.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Project 2"),
        ),
        body: Container(
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
      ),
      routes:{
        './job-description':(ctx)=>JobDescription()
      },
    );
  }
}

