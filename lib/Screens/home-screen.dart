import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_app/DataTest/categoriesList.dart';

import 'package:deliver_app/DataTest/placesList.dart';
import 'package:deliver_app/Model/globals.dart';

import 'package:deliver_app/Model/neighborhood-model.dart';
import 'package:deliver_app/Service/tele_service.dart';
import 'package:deliver_app/constans.dart';
import 'package:deliver_app/providers/location-info.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Service/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocationProvider locationProvider;
  late Neighborhood neighborhood;
  bool isLoading = true;
  String choice = "الجميع";
  bool isOrderOpen = true;
  bool isInOrder = false;

  Timer? timer;
  var sss;

  // bool? sss;
  @override
  void initState() {
    super.initState();
    initializeLocation();
    sss = FirebaseFirestore.instance
        .collection('orders')
        .where(
          'User ID',
          isEqualTo: FirebaseAuth.instance.currentUser,
        )
        .where('Order Status', isEqualTo: false)
        .get();
    if (!isOrderOpen) {
      startTimer();
      timer = Timer.periodic(
        Duration(seconds: 5),
        (_) {
          Future checkEmailVerified() async {
            await FirebaseAuth.instance.currentUser!.reload();
            setState(() {
              isOrderOpen;
              sss = FirebaseFirestore.instance
                  .collection('orders')
                  .where(
                    'User ID',
                    isEqualTo: FirebaseAuth.instance.currentUser,
                  )
                  .where('Order Status', isEqualTo: false)
                  .snapshots();
              ;
            });
            if (isOrderOpen) timer?.cancel();
          }
        },
      );
    }
    checkInOrder();
  }

  Future<bool> checkInOrder() async {
    List<Map<String, dynamic>> orderDataList = await printOrders();

    if (orderDataList.isEmpty) {
      print('The order data list is empty.');
      setState(() {
        isInOrder = false;
      });
      return false;
    } else {
      setState(() {
        isInOrder = true;
      });
      print('The order data list is not empty.');
      // Perform additional actions with the non-empty list

      print(" json ues" + orderDataList.first['Place Name']);
      print(" json ues" + orderDataList.first['Order Detials']);
      print(" json ues" + orderDataList.first['Order Date']);

      String name = orderDataList.first['Place Name'];
      String details = orderDataList.first['Order Detials'];
      String date = orderDataList.first['Order Date'];
      var controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse('https://flutter.dev'));

      showModalBottomSheet(
          isDismissible: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (contex) {
            var width = MediaQuery.of(context).size.width;
            var height = MediaQuery.of(context).size.height;
            return Dialog(
              backgroundColor: Theme.of(context).backgroundColor,
              insetPadding: EdgeInsets.symmetric(vertical: 1),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: height * 0.50,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.lastorder,
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "${AppLocalizations.of(contex)!.placeName}: $name \n\n"
                          "${AppLocalizations.of(contex)!.details}: $details \n\n"
                          "${AppLocalizations.of(context)!.orderdate}: $date"),
                      Text(
                        AppLocalizations.of(context)!.fees,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.red,
                              onPressed: () {
                                printOrders();
                                print("yes");
                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!.not,
                                  style: TextStyle(
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.bold))),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blueAccent,
                              onPressed: () async {
                                String url = "https://wa.me/966543437467";
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                                printOrders();
                                print("yes");
                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!.support,
                                  style: TextStyle(
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.bold))),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: Colors.greenAccent,
                            onPressed: () async {
                              await reciveOrders();
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.received,
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            );
          });

      return true;
    }
  }

  Timer? _timer;

  @override
  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer!.cancel();
    super.dispose();
  }

  var Time = DateFormat.yMMMd().format(DateTime.now());
  DateTime timee = DateTime.now();

  void startTimer() {
    const duration = Duration(seconds: 5);
    _timer = Timer.periodic(duration, (Timer timer) {
      // Show the dialog every minute
    });
  }

  Future<void> initializeLocation() async {
    locationProvider = LocationProvider();
    bool isPermissionGranted =
        await locationProvider.checkAndRequestPermission();
    if (isPermissionGranted) {
      neighborhood = await locationProvider.retrieveLocation();

      setState(() {
        isLoading = false;
      });
    } else {
      initializeLocation();
    }
  }

  Future<void> checkPendingOrder() async {
    setState(() async {
      isInOrder = await checkInOrder();
    });
    if (isInOrder) {}
  }

//
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    var user = FirebaseAuth.instance.currentUser!.uid;
    Set<int> setOfInts = Set();
    setOfInts.add(Random().nextInt(999999999));
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    String? orders;
    bool orderstatus = false;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF32d951),
        onPressed: () async {
          String url = "https://wa.me/966543437467";
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          }
        },
        child: Image.asset(
          'assets/whats-logo.png',
          width: width * 0.09,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/app_log.png'),
                        radius: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: colorBlue,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                AppLocalizations.of(context)!.location,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () async {},
                            child: Row(
                              children: [
                                Text(
                                  "${neighborhood.neighborhood}،${neighborhood.street}",
                                  style: TextStyle(
                                      color: colorSteelGray,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      hintText: 'Search',
                      filled: true,
                      fillColor: colorVeryLightGray,
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Text(
                    AppLocalizations.of(context)!.categories,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  height: height * 0.06,
                  child: ListView.builder(
                    itemCount: categoriesList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      bool isTapped = false;
                      if (choice == categoriesList[index].name) isTapped = true;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            choice = categoriesList[index].name;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: colorWhite,
                              border: Border.all(
                                  color: isTapped
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2)),
                          margin: EdgeInsets.only(left: width * 0.05, right: 2),
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.005,
                              horizontal: width * 0.05),
                          child: Row(
                            children: [
                              Image.asset(
                                categoriesList[index].icon,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                categoriesList[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.more,
                        style: TextStyle(
                            color: colorSteelGray,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        AppLocalizations.of(context)!.near,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.28,
                  child: ListView.builder(
                    itemCount: placeList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (!neighborhood.neighborhood
                          .contains(placeList[index].nieprhood)) {
                        print("false");
                        return Container();
                      } else {
                        print("true");
                        if (!(placeList[index].type.contains(choice) ||
                            choice == "الجميع"))
                          return Container();
                        else
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await checkInOrder();

                                  isInOrder
                                      ? Container()
                                      : showModalBottomSheet(
                                          isDismissible: true,
                                          useSafeArea: true,
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (contex) {
                                            return Dialog(
                                              backgroundColor: Theme.of(context)
                                                  .backgroundColor,
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 1),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                height: height * 0.50,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        placeList[index].name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.07,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      TextField(
                                                          onChanged: (value) =>
                                                              orders = value,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          minLines: 5,
                                                          maxLines: 10,
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon: Icon(Icons
                                                                .local_grocery_store_sharp),
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            label: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .details),
                                                            labelStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          )),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .fees,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          MaterialButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                              color: Colors.red,
                                                              onPressed: () {
                                                                printOrders();
                                                                print("yes");
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .cancel,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.04,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                          MaterialButton(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                            color: Colors
                                                                .blueAccent,
                                                            onPressed:
                                                                () async {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'orders')
                                                                  .doc()
                                                                  .set({
                                                                    'Place Name':
                                                                        placeList[index]
                                                                            .name
                                                                            .trim(),
                                                                    'Order Number':
                                                                        setOfInts
                                                                            .toString(),
                                                                    'Order Date':
                                                                        Time,
                                                                    'Order Status':
                                                                        orderstatus,
                                                                    'Order Detials':
                                                                        orders,
                                                                    'User ID':
                                                                        user
                                                                  })
                                                                  .then((value) =>
                                                                      isOrderOpen =
                                                                          false)
                                                                  .then((value) =>
                                                                      startTimer())
                                                                  .then(
                                                                      (value) {
                                                                    String
                                                                        message =
                                                                        """
                                                          
                                                          Restaurant name: ${placeList[index].name}\n
                                                          Restaurant type: ${placeList[index].type}\n
                                                          Restaurant Neighborhood: ${placeList[index].nieprhood}\n
                                                          Client name: ${userAccount.fname}\n
                                                          Client phone: ${userAccount.phoneNumber}\n
                                                          Client email: ${userAccount.email}\n
                                                          Shortcut Location: ${placeList[index].coordinates}\n
                                                          Orders: \n${orders}
                                                          """;

                                                                    sendMessage(
                                                                        message);
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                            },
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .send,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.04,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: colorLightGray,
                                    border: Border.all(color: colorDarkGray),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                            0.3), // Replace with your desired shadow color
                                        blurRadius:
                                            5, // Replace with your desired blur radius
                                        spreadRadius:
                                            0, // Set to 0 to restrict shadow to the bottom
                                        offset: Offset(0,
                                            8), // Adjust the offset for desired shadow position
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                      left: width * 0.05, right: 2),
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.005,
                                      horizontal: width * 0.03),
                                  //I have change thw width to 0.03
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.12,
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .opentext,
                                              style: TextStyle(
                                                  color: Color(0xFF49EE20),
                                                  fontSize: 18))),
                                      Image.asset(
                                        placeList[index].image,
                                        height: height * 0.2,
                                      ),
                                      SizedBox(
                                        width: width * 0.12,
                                      ),
                                      // Container(
                                      //   child: InkWell(
                                      //     child: Container(
                                      //       height: 50,
                                      //       width: 45,
                                      //       decoration: BoxDecoration(
                                      //         color: colorVeryLightGray,
                                      //         borderRadius: BorderRadius.all(
                                      //             Radius.circular(10)),
                                      //         boxShadow: [
                                      //           BoxShadow(
                                      //             color: Colors.grey.withOpacity(
                                      //                 0.5), // Replace with your desired shadow color
                                      //             spreadRadius:
                                      //                 1, // Replace with your desired spread radius
                                      //             blurRadius:
                                      //                 5, // Replace with your desired blur radius
                                      //             offset: Offset(0,
                                      //                 3), // Replace with your desired offset
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       child: Icon(
                                      //         Icons.favorite_border,
                                      //         color: Color(0xFFFF9832),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width * 0.6,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: width * 0.6,
                                      child: AutoSizeText(
                                        placeList[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        minFontSize: 10,
                                        maxLines: 2,
                                      ),
                                      // child: AutoSizeText(
                                      //   'Hello Geeks! We will break this line into 3 lines !!ssssssssssssssss sssssss',
                                      //   style: TextStyle(fontSize: 30.0),
                                      //   maxLines: 1,
                                      // ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  padding: EdgeInsets.all(15),
                  width: width,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                      color: colorVeryLightGray,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.offer,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
