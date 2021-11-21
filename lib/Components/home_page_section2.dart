import 'package:easyupi/DataController/recents_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

var recentsController = Get.put(RecentsController());

Widget HomePageSection2() {
  if(recentsController.recents.length>0) {
    return Row(
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
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Text(
                              recentsController.recents[index].pName.characters
                                  .first.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, color: yellow),),
                            backgroundColor: grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(recentsController.recents[index].pName,
                              style: GoogleFonts.montserrat(
                                  fontSize: 10, color: Colors.white),),
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
    );
  }else{
    return Container();
  }
}