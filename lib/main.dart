import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project2/logics/register/post.dart';
import 'package:project2/screens/job_description.dart';
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
import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Register(),
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
                                data.isNotEmpty? Navigator.pushNamed(
                                    context, './screens/user-details',
                                    arguments: data)
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
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
                      UserForm((mytitle, myprice, mydescription) {
                        postData(mytitle, myprice, mydescription);
                        setState(() {
                          JobList.add(JobDetails(
                              id: 'lmno-${JobList.length + 1}-qrst',
                              title: mytitle,
                              image:
                                  'https://cdn.pixabay.com/photo/2017/12/25/16/16/creativity-3038628_960_720.jpg',
                              price: myprice,
                              description: mydescription,
                              userid: FirebaseAuth.instance.currentUser!.uid));
                        });
                      }),
                      FutureBuilder<Map>(
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
                              JobList.add(JobDetails.fromjson(value));
                            });
                            return CardLayout(JobList);
                          })),
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
        './screens/job-request': (ctx) => const RequestDetailsScreen(),
      },
    );
  }
}
