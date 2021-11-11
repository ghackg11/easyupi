import 'package:easyupi/DataController/recents_controller.dart';
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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  var recentsController = Get.put(RecentsController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: lightBlack,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              HomePageSection1(),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Divider(
                      color: Colors.white,
                    ),
                    width: 18,
                    padding: EdgeInsets.only(top: 15, right: 5),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Recents',
                              style: GoogleFonts.montserrat(color: grey),
                            ),
                            Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: TextButton(
                                      child: Text(
                                        'See All(${recentsController.recents.length})',
                                        style: GoogleFonts.montserrat(color: grey),
                                      ),
                                      onPressed: () {},
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          height: 110,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: recentsController.recents.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Text(recentsController.recents[index].pName.characters.first.toString(), style: GoogleFonts.montserrat(fontSize: 20, color: yellow),),
                                      backgroundColor: grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(recentsController.recents[index].pName, style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white),),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],

                    ),
                  )
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: lightBlack,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(LineIcons.history, color: Colors.white),
              tooltip: "History",
            ),
            IconButton(
              onPressed: null,
              icon: Icon(Icons.person, color: Colors.white),
              tooltip: "Account",
            ),
          ],
        ),
        drawer: Drawer(),
      ),
    );
  }
}
