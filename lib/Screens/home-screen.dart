import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_app/DataTest/categoriesList.dart';
import 'package:deliver_app/DataTest/placesList.dart';

import 'package:deliver_app/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _userid = FirebaseAuth.instance.currentUser!.uid;
    Set<int> setOfInts = Set();
    setOfInts.add(Random().nextInt(999999999));
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    String Time = DateFormat.yMMMd().format(DateTime.now());
    String? orders;




    bool orderstatus = false;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF32d951),
        onPressed: () {},
        child: Image.asset(
          'assets/whats-logo.png',
          width: width * 0.09,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: height * 0.02),
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
                        Row(
                          children: [
                            Text(
                              "شارع التضامن العربي،مشرفة",
                              style: TextStyle(
                                  color: colorSteelGray,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
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
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: colorWhite,
                      ),
                      margin: EdgeInsets.only(left: width * 0.05, right: 2),
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.005, horizontal: width * 0.05),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    return Container(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => showModalBottomSheet(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                backgroundColor: ThemeData().backgroundColor,
                                context: context,
                                isDismissible: false,
                                enableDrag: true,
                                builder: (builder) {
                                  return Container(
                                    height: height * 0.50,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            placeList[index].name,
                                            style: TextStyle(
                                                fontSize: width * 0.07,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 9, right: 9),
                                            child: TextFormField(
                                                onChanged: (value) =>
                                                    orders = value,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                minLines: 5,
                                                maxLines: 10,
                                                decoration: InputDecoration(
                                                  suffixIcon: Icon(Icons
                                                      .local_grocery_store_sharp),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  label: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .deitals),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!.fees,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  color: Colors.red,
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel,
                                                      style: TextStyle(
                                                          fontSize:
                                                              width * 0.04,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                color: Colors.blueAccent,
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('orders')
                                                      .doc()
                                                      .set({
                                                    'Place Name':
                                                        placeList[index]
                                                            .name
                                                            .trim(),
                                                    'User ID': _userid,
                                                    'Order Number':
                                                        setOfInts.toString(),
                                                    'Order Date': Time,
                                                    'Order Status': orderstatus,
                                                    'Order Detials': orders
                                                  });
                                                  // setNeworders(
                                                  //     placeList[index]
                                                  //         .name
                                                  //         .trim(),
                                                  //     _userid,
                                                  //     setOfInts,
                                                  //     Time,
                                                  //     orderstatus,
                                                  //     orders!);

                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .send,
                                                  style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  );
                                }),
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
                              margin:
                                  EdgeInsets.only(left: width * 0.05, right: 2),
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.005,
                                  horizontal: width * 0.03),
                              //I have change thw width to 0.03
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.opentext,
                                      style: TextStyle(
                                          color: Color(0xFF49EE20),
                                          fontSize: 18)),
                                  Image.asset(
                                    placeList[index].image,
                                    height: height * 0.2,
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
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
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        placeList[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Row(
                                        children: [
                                          Text(placeList[index].rate),
                                          Icon(Icons.star,
                                              color: Color(0xFFFF9832))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
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
    );
  }
}
