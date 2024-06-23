import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Features/Box/presentation/pill_box.dart';
import 'package:pulse/Features/home/presentation/widgets/current_date.dart';
import 'package:pulse/Features/home/presentation/widgets/no_search.dart';
import 'package:pulse/Features/home/presentation/widgets/refill_drugs&pill_box_circle.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userName = '';
  bool isSearched = false;
  String uid = getIt.get<FirebaseAuth>().currentUser!.uid;

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: const Color(0xffD5EDF2),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 22,
            padding: const EdgeInsetsDirectional.only(start: kPaddingView),
            color: const Color(0xffD5EDF2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logoFree.png',
                      color: const Color(0xff407CE2),
                      width: Get.width * .25,
                      height: Get.height * .12,
                      fit: BoxFit.cover,
                    ),
                    Text(S.of(context).welcome,
                        style: Styles.textStyleNormal14),
                    const SizedBox(width: 10.0),
                    Text(userName, style: Styles.textStyleSemiBold14),
                  ],
                ),
                const CurrentDate(),
              ],
            ),
          ),
          Positioned(
            top: Get.height * .24,
            child: Container(
              width: Get.width,
              height: Get.height,
              padding: const EdgeInsetsDirectional.all(kPaddingView),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // RefillDrugsPillBoxCircle(
                        //   text: S.of(context).refillDrugs,
                        //   image: 'assets/images/refill drugs.svg',
                        // ),
                        InkWell(
                          child: RefillDrugsPillBoxCircle(
                            text: S.of(context).pillBox,
                            image: 'assets/images/unselected_medication.svg',
                          ),
                          onTap: () {
                            Get.to(PillBoxView());
                          },
                        ),
                      ]),
                  const SizedBox(height: 15.0),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass,
                          color: Colors.grey, size: 22),
                      hintText: S.of(context).searchForAlternatives,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff407CE2)),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      contentPadding: const EdgeInsets.all(23.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE4E4E5)),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    onSubmitted: (value) {
                      //print(value);
                      isSearched = true;
                      searchForAlternatives(value);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: Get.height / 2.5,
                    child: isSearched == false
                        ? const NoSearch()
                        : FutureBuilder<DocumentSnapshot>(
                            future: getIt
                                .get<FirebaseFirestore>()
                                .collection('rec')
                                .doc(uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(S.of(context).somethingWentWrong),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data == null) {
                                return const Center(child: NoSearch());
                              }
                              try {
                                if (snapshot.data!['drug_rec'].length < 1) {
                                  return Center(
                                      child: Text(
                                          S.of(context).enterACompleteMedName,
                                          style: Styles.textStyleNormal16));
                                }
                                return Column(
                                  children: [
                                    Text(
                                      S.of(context).alternatives,
                                      style: Styles.textStyleMedium18
                                          .copyWith(color: Colors.blue[700]),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: Get.height / 3.7,
                                      child: ListView.builder(
                                        itemCount:
                                            snapshot.data!['drug_rec'].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Card(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text(
                                                            '${snapshot.data!['drug_rec'][index]}',
                                                            style: Styles
                                                                .textStyleMedium18,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.check,
                                                        color:
                                                            Colors.green[700],
                                                        size: 40,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } catch (e) {
                                return const Center(child: NoSearch());
                              }
                            }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getUserName() async {
    final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    final res =
        await getIt.get<FirebaseFirestore>().collection('users').doc(uid).get();
    List<String> ls = res.data()!['name'].toString().split(' ');
    //print(ls);
    userName = ls[0];
    setState(() {});
  }

  void searchForAlternatives(String dName) async {
    CollectionReference rec = FirebaseFirestore.instance.collection('rec');

    rec.doc(uid).set({'drug': dName});
    setState(() {});
    Future.delayed(const Duration(milliseconds: 1700), () {
      setState(() {});
    });
  }
}
// ReservedMedicine(
//   isTaken: true,
//   text: S.of(context).paracetamol,
//   image: 'assets/images/tablet.png',
//   medicationTime: S.of(context).medicationTime,
//   date: S.of(context).date,
//   frequency: S.of(context).frequency,
// ),
// SizedBox(height: Get.height * .01),
// ReservedMedicine(
//   isTaken: false,
//   text: S.of(context).paracetamol,
//   image: 'assets/images/tablet.png',
//   medicationTime: S.of(context).medicationTime,
//   date: S.of(context).date,
//   frequency: S.of(context).weekly,
// ),
