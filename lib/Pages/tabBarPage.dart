import 'package:flutter/material.dart';
import 'package:otp_verification/Pages/emailPage.dart';
import 'package:otp_verification/Pages/homePage.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>{



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 125, left: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 29,
                      color: Colors.grey.shade900),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4, left: 20),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0),
                  child: Text(
                    'Please enter your Phone or Email',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
              ),
              Container(
                width: 350,

                child: TabBar(
                  indicatorWeight: 6,
                  padding: EdgeInsets.only(top: 30),
                  indicatorColor: Colors.yellow,
                    tabs: [
                  Tab(text: 'Phone',),
                  Tab(text: 'Email',),
                ],
                ),
              ),
              SizedBox(
                height: 620,
                child: TabBarView(
                  children: [
                    HomePage(),
                    EmailPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}