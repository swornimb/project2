

import 'dart:math';

import 'package:flutter/material.dart';




class UserForm extends StatelessWidget {

  final Function addonList;
  UserForm(this.addonList);



  

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  String _mytitle="";
  String mydescription="";
  String myprice="";
  String mydate="";
  titleInput(String value){
    _mytitle = value;
  }
  descriptionInput(String value){
    mydescription = value;
  }
  priceInput(String value){
    myprice = value;
  }
  dateInput(String value){
    mydate = value;
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formkey,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
            child: ListView(
                children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: TextFormField(
                          onChanged: titleInput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Job Title"),
                          ),
                          validator:(String? value){
                            if(value == null || value.isEmpty){
                              return "Please enter Title";
                            }else{
                              return null;
                            }
                          } ,
                        ),
                      ),
                      // DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2100),),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: TextFormField(
                            onChanged: descriptionInput,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Job Description")
                          ),
                          minLines: 5,
                          maxLines: 50,
                            validator:(String? value){
                              if(value == null || value.isEmpty){
                                return "Please enter Description";
                              }else{
                                return null;
                              }
                            }
                        ),

                      ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: ()async{
                                final DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                                
                                  String mydate = date.toString();
                                
                              },
                              child: Icon(Icons.calendar_month, color: Colors.white,),
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                              onChanged: priceInput,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Price")
                              ),
                              validator:(String? value){
                                if(value == null || value.isEmpty){
                                  return "Please enter Price";
                                }else{
                                  return null;
                                }
                              }
                          ),
                        ),
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(
                              style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 20))),
                              onPressed: (){
                                
                                if(_formkey.currentState!.validate()){
                                  addonList((new DateTime.now().millisecondsSinceEpoch.toInt()* Random().nextInt(9999999)*Random().nextInt(999999)).toString(), _mytitle, myprice, mydescription);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                  content: Text('Data Stored')),
                              );
                                }
                              },
                              child: Text("Submit", style:TextStyle(fontWeight: FontWeight.bold))
                        ),
                            ),
                      ],
                    ),
                  ),
                    ],
                  )
        ),
      ),
    );
  }
}
