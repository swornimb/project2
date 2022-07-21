import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCU_HyyMy_VBE5hSSHxQvQvfP_6HAdUFec",
          appId: "1:307364843752:android:fa3cb338f61d7004d8395d",
          messagingSenderId: "307364843752",
          projectId: "jobfinder-c2051"));
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          icon: Icon(Icons.person)
                          ),
                          IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          icon: Icon(Icons.logout)
                          ),
                    ],
                    bottom: TabBar(
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
                        setState(() {
                          JobList.add(JobDetails(
                              id: 'l${JobList.length + 1}',
                              title: mytitle,
                              image:
                                  'https://cdn.pixabay.com/photo/2017/12/25/16/16/creativity-3038628_960_720.jpg',
                              price: myprice,
                              description: mydescription,
                              userid: 'u2'));
                        });
                      }),
                      CardLayout(JobList)
                    ],
                  )),
            );
          }
        },
      ),
      theme: ThemeData(
          fontFamily: 'Raleway',
          primarySwatch: Colors.blue,
          primaryTextTheme: TextTheme(
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
