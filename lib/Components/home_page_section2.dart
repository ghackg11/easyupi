import 'package:easyupi/DataController/recents_controller.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

Widget HomePageSection2() {
  RecentsController controller = Get.put(RecentsController());

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
                DescribedFeatureOverlay(
                  featureId: "feature4",
                  overflowMode: OverflowMode.extendBackground,
                  tapTarget: Text(
                    'Recents',
                    style: GoogleFonts.montserrat(color: Colors.orange),
                  ),
                  title: Text("Select from Recents"),
                  child: Text(
                    'Recents',
                    style: GoogleFonts.montserrat(color: grey),
                  ),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          child: Text(
                            'See All',
                            style: GoogleFonts.montserrat(color: grey),
                          ),
                          onPressed: () {},
                        ),
                      )),
                ),
              ],
            ),
            GetX<RecentsController>(builder: (controller) {
              return SizedBox(
                height: 110,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.recents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Text(
                              controller.recents[index].pName.characters.first.toString(),
                              style: GoogleFonts.montserrat(fontSize: 20, color: yellow),
                            ),
                            backgroundColor: grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              controller.recents[index].pName,
                              style: GoogleFonts.montserrat(fontSize: 10, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      )
    ],
  );
}
