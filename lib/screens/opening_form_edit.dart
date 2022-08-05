import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/logics/jobs/post.dart';

class EditOpeningForm extends StatelessWidget {
  String _mytitle = "";
  String mydescription = "";
  String myprice = "";
  String mydate = "";
  titleInput(String value) {
    _mytitle = value;
  }

  descriptionInput(String value) {
    mydescription = value;
  }

  priceInput(String value) {
    myprice = value;
  }

  dateInput(String value) {
    mydate = value;
  }

  late String id;
  late String title;
  late String description;
  late String price;
  late String keyy;

  @override
  Widget build(BuildContext context) {
    Map payload = ModalRoute.of(context)?.settings.arguments as Map;
    payload.forEach(
      (key, value) {
        keyy = key.toString();
        id = value['id'];
        title = value['title'];
        description = value['description'];
        price = value['price'];
      },
    );
    return Form(
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
                    initialValue: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Job Title"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    onChanged: descriptionInput,
                    initialValue: description,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Job Description")),
                    minLines: 5,
                    maxLines: 50,
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
                              color: Colors.blue),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100));
                              String mydate = date.toString();
                            },
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          initialValue: price,
                          keyboardType: TextInputType.number,
                          onChanged: priceInput,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Price")),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20))),
                            onPressed: () {
                              putData(id, _mytitle, myprice, mydescription,keyy);
                            },
                            child: Text("Submit",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
