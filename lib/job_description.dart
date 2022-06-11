import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/JobDetails.dart';
import './data_list.dart';
class JobDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routsArgs = ModalRoute.of(context)?.settings.arguments as Map<String,Object>;
    String jobid = routsArgs['id'].toString();
    String imagelink = routsArgs['imagelink'].toString();
    String dscription = routsArgs['description'].toString();
    String title = routsArgs['title'].toString();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          child:Column(
            children: [
              Container(
                child: Image.network(imagelink, fit: BoxFit.cover, height: 200, width: double.infinity,)
              ),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(dscription),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: (){},
                  child: Text("Apply Job"),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    primary: Colors.white,
                    backgroundColor: Colors.blue
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}