import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Job Requests"),),
        body: ListView(
          children:  List.generate(80, (index) =>  Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text("Swornim Bhattarai"),
                ),
                TextButton(onPressed: (){}, child: Text("Accept"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)), foregroundColor:MaterialStateProperty.all(Colors.white) )),
                TextButton(onPressed: (){}, child: Text("Reject"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),foregroundColor:MaterialStateProperty.all(Colors.white))),
              ],
            ),
          )
          ),
        )
      ),
    );
  }
}
