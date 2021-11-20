import 'package:easyupi/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionDetailListItem extends StatelessWidget {
  final String recipientName;
  final String phoneNumber;
  final String transactionID;
  final String dateTime;
  final int transactionAmount;
  final String applicationUsed;

  TransactionDetailListItem({
    this.recipientName = "Name",
    this.phoneNumber = "Phone",
    this.transactionID = "transactionID",
    this.dateTime = "Date and Time",
    this.transactionAmount = 0,
    this.applicationUsed = "App Used",
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(color: grey, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: screenWidth,
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "To: " + recipientName,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight / 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30.0),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Phone: " + phoneNumber,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight / 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 90.0),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "on " +
                                    dateTime.split(' ')[0] +
                                    ", at " +
                                    dateTime.split(' ')[1].substring(0, 5),
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight / 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 70.0),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Txn ID: " + transactionID,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight / 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50.0),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.0),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "- ₹ " + transactionAmount.toString(),
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: yellow,
                                    fontSize: screenHeight / 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 70.0),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                applicationUsed,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight / 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
