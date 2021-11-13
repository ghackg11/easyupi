import 'dart:math';
import 'package:easyupi/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upi_pay/upi_pay.dart';

String? amount;

class UpiPayment extends StatefulWidget {

  String phoneNumber;
  String amount;
  UpiPayment(this.phoneNumber, this.amount);

  @override
  _UpiPaymentState createState() => _UpiPaymentState();
}

class _UpiPaymentState extends State<UpiPayment> {


  late Future<List<ApplicationMeta>> _appsFuture;

  @override
  void initState() {
    super.initState();

    // we have declared amount as 999 (i.e. Rs.999).

    // used for getting list of UPI apps installed in current device
    _appsFuture = UpiPay.getInstalledUpiApplications(statusType: UpiApplicationDiscoveryAppStatusType.all);
  }

  @override
  void dispose() {

    // dispose text field controllers after use.
    super.dispose();
  }

  // this will open correspondence UPI Payment gateway app on which user has tapped.
  Future<void> _openUPIGateway(ApplicationMeta app) async {

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    print("Starting transaction with id $transactionRef");

    // this function will initiate UPI transaction.
    final a = await UpiPay.initiateTransaction(
      amount: widget.amount,
      app: app.upiApplication,
      receiverName: 'Mr. XYZ',
      receiverUpiAddress: '${widget.phoneNumber}@paytm',
      transactionRef: transactionRef,
    );

    print(a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlack,
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 32),
                ),

                Container(
                  margin: EdgeInsets.only(top: 128, bottom: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Pay Using',
                          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      FutureBuilder<List<ApplicationMeta>>(
                        future: _appsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return Container();
                          }
                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1.6,
                            physics: NeverScrollableScrollPhysics(),
                            children: snapshot.data!.map((i) => Material(
                              key: ObjectKey(i.upiApplication),
                              color: Colors.grey[200]!.withOpacity(0.3),
                              child: InkWell(
                                onTap: () => _openUPIGateway(i),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    i.iconImage(20),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        i.upiApplication.getAppName(),
                                        style: GoogleFonts.montserrat(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

String? _validateUpiAddress(String value) {
  if (value.isEmpty) {
    return 'UPI Address is required.';
  }


  return null;
}