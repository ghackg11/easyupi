import 'package:easyupi/Components/side_drawer.dart';
import 'package:easyupi/DataController/recents_controller.dart';
import 'package:easyupi/Screens/auth_screen.dart';
import 'package:easyupi/Screens/profile_page.dart';
import 'package:easyupi/Screens/transaction_history_page.dart';
import 'package:easyupi/constants.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'Components/home_page_section1.dart';
import 'Components/home_page_section2.dart';
import 'Components/home_page_section3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GetxController recentsController = Get.put(RecentsController());

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        color: lightBlack,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? AuthScreen()
            : FeatureDiscovery(child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((Duration duration) {
      FeatureDiscovery.discoverFeatures(
        context,
        const <String>{
          // Feature ids for every feature that you want to showcase in order.
          "feature1",
          "feature2",
          "feature3",
          "feature4",
          "feature5",
          "feature6",
          "feature7",
        },
      );
    });

    var scaffoldKey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: lightBlack,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                HomePageSection1(),
                SizedBox(
                  height: 20,
                ),
                HomePageSection2(),
                SizedBox(
                  height: 20,
                ),
                HomePageSection3()
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: lightBlack,
          iconTheme: IconThemeData(color: Colors.white),
          leading: DescribedFeatureOverlay(
            featureId: "feature7",
            overflowMode: OverflowMode.extendBackground,
            tapTarget: Icon(Icons.dehaze, color: Colors.orange),
            onComplete: () async {
              scaffoldKey.currentState?.openDrawer();
              return true;
            },
            title: Text("Open Side Menu"),
            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.dehaze),
            ),
          ),
          actions: [
            DescribedFeatureOverlay(
              featureId: "feature5",
              overflowMode: OverflowMode.extendBackground,
              tapTarget: Icon(LineIcons.history, color: Colors.orange),
              title: Text("Check Transaction History"),
              child: IconButton(
                onPressed: () {
                  Get.to(TransactionHistoryPage());
                },
                icon: Icon(LineIcons.history, color: Colors.white),
                tooltip: "History",
              ),
            ),
            DescribedFeatureOverlay(
              featureId: "feature6",
              overflowMode: OverflowMode.extendBackground,
              tapTarget: Icon(Icons.person, color: Colors.orange),
              title: Text("Check your profile"),
              child: IconButton(
                onPressed: () {
                  Get.to(ProfilePage());
                },
                icon: Icon(Icons.person, color: Colors.white),
                tooltip: "Account",
              ),
            ),
          ],
        ),
        drawer: SideDrawer(context),
      ),
    );
  }
}
