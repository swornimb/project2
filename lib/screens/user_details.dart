import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:project2/logics/user_specific/post.dart';
import 'package:project2/models/JobDetails.dart';
import 'package:project2/screens/card_layout.dart';

import '../logics/register/post.dart';

class UserDetails extends StatefulWidget {
  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String myprice = "";
  String keyy = "";
  Map? data;
  priceInput(String value) {
    myprice = value;
  }

  List<JobDetails> userjob = [];

  bool moneyvisible = true;
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    Map dataArgs = ModalRoute.of(context)?.settings.arguments as Map;

    dataArgs.forEach((key, value) {
      keyy = key.toString();
    });
    List x = dataArgs.values.toList();
    List? work = x[0]['work']?.split(',');

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("User Details"), actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, './userFuture',
                    arguments: userjob);
              },
              icon: Icon(Icons.list)),
          IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed('./screens/job-request');
              }),
        ]),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            alignment: Alignment.center,
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FirebaseAuth.instance.currentUser!.uid == x[0]['uid']
                          ? Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        moneyvisible = !moneyvisible;
                                      });
                                    },
                                  ),
                                ),
                                moneyvisible
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Text(x[0]['wallet'],
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      )
                                    : Container(
                                        alignment: Alignment.centerLeft,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Text("XXXX.XX",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                              ],
                            )
                          : Text(" "),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 100,
                    width: double.minPositive,
                    // decoration: BoxDecoration(
                    //     border: Border.all(width: 1, color: Colors.blue),
                    //     borderRadius: BorderRadius.circular(10)),
                    child: Image.network(x[0]['imageurl'])),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Description",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                Text(
                  x[0]['description'],
                  style: TextStyle(color: Colors.black54, height: 1.5),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Skills",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var i in x[0]['skills'])
                      Badge(
                        badgeContent: Text(
                          i,
                          style: TextStyle(color: Colors.white),
                        ),
                        badgeColor: Colors.blue,
                        shape: BadgeShape.square,
                        borderRadius: BorderRadius.circular(5),
                      ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Projcts Done",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var i in work!)
                      if (work.indexOf(i) == 0)
                        Badge(
                          badgeContent: Wrap(
                            children: [
                              Container(
                                child: Text(
                                  i,
                                  style: TextStyle(color: Colors.white),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                              )
                            ],
                            alignment: WrapAlignment.center,
                          ),
                          badgeColor: Colors.blue,
                          shape: BadgeShape.square,
                          borderRadius: BorderRadius.circular(5),
                        ),
                  ],
                ),
                FirebaseAuth.instance.currentUser!.uid == x[0]['uid']?Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Flexible(
                    flex: 1,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: priceInput,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), label: Text("Money")),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Price";
                          } else {
                            return null;
                          }
                        }),
                  ),
                ):Text(""),
                FirebaseAuth.instance.currentUser!.uid == x[0]['uid']?Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20))),
                      onPressed: () async {
                        FirebaseAuth.instance.currentUser!.uid == x[0]['uid']? await makePayment()
                            : Text("You Cant load money");
                         loadmoney(x[0], keyy, myprice);
                      },
                      child: Text("Load Money",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ):Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  makePayment() async {
    paymentIntentData = await createPaymentInter(myprice, 'USD');
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            applePay: PaymentSheetApplePay(merchantCountryCode: "US"),
            googlePay: PaymentSheetGooglePay(merchantCountryCode: "US"),
            merchantDisplayName: 'Swornim'));
    displayPaymentSheet();
  }

  displayPaymentSheet() async {
    Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true));
    setState(() {
      paymentIntentData = null;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Paid Successfully")));
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  createPaymentInter(String amount, String currency) async {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card'
    };

    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51LUYzLSCgSEsIpqaau2IuW3uxma5uKAB698rpKPotVlAXIXVo7AXhJpvfipHJEcrLiQ9tyl8TNlHfiK9QzNW10pr00PEQiZhUI',
          'Content-Type': 'application/x-www-form-urlencoded'
        });

    return jsonDecode(response.body.toString());
  }
}
