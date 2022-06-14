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
      theme: ThemeData(
        fontFamily: 'Raleway'
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Column(

            children: [

              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Image.network(imagelink, fit: BoxFit.cover, height: 200, width: double.infinity,)
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical:10, horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(title, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Text("Swornim Bhattarai"),
                  onTap: (){
                    Navigator.of(context).pushNamed('./user-details');
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical:10, horizontal: 20),
                alignment: Alignment.center,
                child: Text(dscription, style: TextStyle(color: Colors.black54, height: 1.5),),

              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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