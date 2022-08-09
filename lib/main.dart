import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project2/logics/register/post.dart';
import 'package:project2/logics/user_specific/post.dart';
import 'package:project2/screens/job_description.dart';
import 'package:project2/screens/opening_form_edit.dart';
import 'package:project2/screens/request_dart.dart';
import 'package:project2/screens/sign_in.dart';
import 'screens/card_layout.dart';
import 'datas/jobs_list.dart';
import 'screens/user_details.dart';
import 'screens/opening_form.dart';
import 'screens/loading.dart';
import './screens/data_register.dart';
import 'models/JobDetails.dart';
import './logics/jobs/post.dart';
import './screens/user_specific.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51LUYzLSCgSEsIpqaMTj5E4jCl7xDNBO3lDBr1JmBZHILu5F6DDeghDkI3aqWekl4O66IF7geRp9eiNiV5pkBhVr200yd6COZd9";

  await Firebase.initializeApp(
      name: "JobFinder",
      options: const FirebaseOptions(
        apiKey: "AIzaSyCU_HyyMy_VBE5hSSHxQvQvfP_6HAdUFec",
        appId: "1:307364843752:android:fa3cb338f61d7004d8395d",
        messagingSenderId: "307364843752",
        projectId: "jobfinder-c2051",
        storageBucket: "gs://jobfinder-c2051.appspot.com",
      ));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  data() {
    setState(() {
      getData();
    });
    return getData();
  }

  var userlat;
  var userlon;

  double sortdata(lat2, lon2) {
    print(userlat);
    var p = 0.017453292519943295;
    var c = cos;
    double a = 0.5 -
        c((double.parse(lat2) - double.parse(userlat)) * p) / 2 +
        c(double.parse(userlat) * p) *
            c(double.parse(lat2) * p) *
            (1 - c((double.parse(lon2) - double.parse(userlon)) * p)) /
            2;
    print(userlat);
    return (12742 * asin(sqrt(a)));
  }

  void mustrun() async {
    print("object");
    var x = await getDataRegister();
    print("bvdajsdja");
    x.forEach((key, value) {
      setState(() {
        userlat = value['lat'];
        print('print1');
        userlon = value['lon'];
        print('print2');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initruning');
    mustrun();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: EditOpeningForm(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Loading();
          }

          if (!snapshot.hasData) {
            return SignIn();
          } else {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text("Project 2"),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            var data = await getDataRegister();
                            data.isNotEmpty
                                // ignore: use_build_context_synchronously
                                ? Navigator.pushNamed(
                                    context, './screens/user-details',
                                    arguments: data)
                                // ignore: use_build_context_synchronously
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                          },
                          icon: Icon(Icons.person)),
                      IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          icon: Icon(Icons.logout)),
                    ],
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.add),
                          text: "Add Jobs",
                        ),
                        Tab(
                          icon: Icon(Icons.list),
                          text: "Job List",
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      UserForm((id, mytitle, myprice, mydescription, location,
                          latitude, longitude) {
                        postData(id, mytitle, myprice, mydescription, location,
                            latitude, longitude);
                        setState(() {
                          JobList.add(JobDetails(
                              id: id,
                              title: mytitle,
                              image:
                                  'https://cdn.pixabay.com/photo/2017/12/25/16/16/creativity-3038628_960_720.jpg',
                              price: myprice,
                              description: mydescription,
                              userid: FirebaseAuth.instance.currentUser!.uid,
                              location: location,
                              lat: latitude,
                              lon: longitude,
                              distance: 0));
                        });
                      }),
                      RefreshIndicator(
                          onRefresh: () {
                            return data();
                          },
                          child: FutureBuilder<Map>(
                              future: getData(),
                              builder: ((context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                Map? response = snapshot.data;
                                List<JobDetails> JobList = [];
                                response!.forEach((key, value) {
                                  JobDetails data = JobDetails.fromjson(value);
                                  data.distance = sortdata(data.lat, data.lon);
                                  print(data.distance);
                                  JobList.add(data);
                                });

                                JobList.sort((a, b) =>
                                    a.distance!.compareTo(b.distance!.round()));

                                return CardLayout(JobList);
                              })))
                    ],
                  )),
            );
          }
        },
      ),
      theme: ThemeData(
          fontFamily: 'Raleway',
          primarySwatch: Colors.blue,
          primaryTextTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          )),
      routes: {
        './job-description': (ctx) => JobDescription(),
        './screens/user-details': (ctx) => UserDetails(),
        './screens/job-request': (ctx) => RequestDetailsScreen(),
        './userFuture': (ctx) => UserSpecific(),
        './foredit': (ctx) => EditOpeningForm(),
      },
    );
  }
}
