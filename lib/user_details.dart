import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class UserDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("User Details",)),
        body:Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.blue), 
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png')
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text("Swornim Bhattarai",
                  style: TextStyle(fontWeight: FontWeight.w900) ,),
              ),
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions."),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text("Skills", style: TextStyle(fontWeight: FontWeight.w900) ,),
              ),

                 Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [

                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Badge(
                      badgeContent: Text("Cleaning", style: TextStyle(color: Colors.white),),
                      badgeColor: Colors.blue,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text("Projcts Done", 
                  style: TextStyle(fontWeight: FontWeight.w900) ,
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Badge(
                    badgeContent: Wrap(children: [Badge(shape: BadgeShape.circle, badgeContent: Text("5"),padding: EdgeInsets.all(10),), Container(child: Text("Cleaning"), margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),)], alignment: WrapAlignment.center,),
                    badgeColor: Colors.blue,
                    shape: BadgeShape.square,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  Badge(
                    badgeContent: Wrap(children: [Badge(shape: BadgeShape.circle, badgeContent: Text("5"),padding: EdgeInsets.all(10),), Container(child: Text("Cleaning"), margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),)], alignment: WrapAlignment.center,),
                    badgeColor: Colors.blue,
                    shape: BadgeShape.square,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  Badge(
                    badgeContent: Wrap(children: [Badge(shape: BadgeShape.circle, badgeContent: Text("5"),padding: EdgeInsets.all(10),), Container(child: Text("Cleaning"), margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),)], alignment: WrapAlignment.center,),
                    badgeColor: Colors.blue,
                    shape: BadgeShape.square,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              )
            ],
          ),
        ) ,
      ),
    );


  }
}
