import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardLayout extends StatelessWidget {
  String id;
  String imagelink;
  double price;
  String title;
  String description;

  CardLayout({required this.id,required this.price, required this.title, required this.imagelink, required this.description});
  
  void selectedJob(BuildContext ctx){
    Navigator.of(ctx).pushNamed('./job-description', arguments: {'id': id, 'imagelink': imagelink, 'price': price, 'title': title, 'description': description});
  }

  @override
  Widget build(BuildContext context) {
    return
        InkWell(
          onTap: ()=>selectedJob(context),
          child: Column(
            children:[
              Container(
                width: double.infinity,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
                  child:  Image.network(imagelink, fit: BoxFit.cover,),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey), borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),), margin: EdgeInsets.all(5),),
                      Container(child: Row(children:[ Icon(Icons.currency_rupee, color: Colors.amber,size: 12,),Text(price.toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.blue),)]), margin: EdgeInsets.all(5)),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
  }
}
