import 'package:easyupi/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'Components/home_page_section1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: lightBlack,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: lightBlack,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20,),
              HomePageSection1(),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: lightBlack,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(onPressed: null, icon: Icon(LineIcons.history, color: Colors.white), tooltip: "History",),
            IconButton(onPressed: null, icon: Icon(Icons.person, color: Colors.white), tooltip: "Account",),
          ],
        ),
        drawer: Drawer(

        ),
      ),
    );
  }


  
}