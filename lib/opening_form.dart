import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
                              },
                              child: Icon(Icons.calendar_month, color: Colors.white,),
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Price")
                              ),
                              validator:(String? value){
                                if(value == null || value.isEmpty){
                                  return "Please enter Description";
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
                              onPressed: (){},
                              child: Text("Submit", style:TextStyle(fontWeight: FontWeight.bold)),

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
