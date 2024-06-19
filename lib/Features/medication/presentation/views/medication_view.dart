import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Features/BottomNavBar/presentation/manager/nav_controller.dart';
import 'package:pulse/Features/medication/data/repo/med_repo.dart';
import 'package:pulse/Features/medication/presentation/widgets/active_meds_item.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/sql_database.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/generated/l10n.dart';

class MedicationView extends StatefulWidget {
  const MedicationView({super.key});

  @override
  State<MedicationView> createState() => _MedicationViewState();
}

List<Map> activeMeds = [];
List<Map> inactiveMeds = [];
List<Map> allMeds = [];
List<List<String>> activePeriods = [];
List<List<String>> inactivePeriods = [];
MedRepo medRepo = MedRepo();

class _MedicationViewState extends State<MedicationView> {
  @override
  void initState() {
    super.initState();
    raedMeds();
  }

  void raedMeds() async {
    SqlDb sqlDb = SqlDb();
    activeMeds = [];
    inactiveMeds = [];
    activePeriods = [];
    inactivePeriods = [];
    allMeds = [];
    allMeds.addAll(await sqlDb.read('meds'));
    for (var element in allMeds) {
      if (element['isActive'] == 1) {
        activeMeds.add(element);
      } else {
        inactiveMeds.add(element);
      }
      //print('==================================');
      //print(element['id']);
    }
    ////test
    //inactiveMeds.addAll(await sqlDb.read('meds'));
    for (var element in allMeds) {
      List<String> tmp = medRepo.medPeriod(element['periods']);
      if (element['isActive'] == 1) {
        activePeriods.add(tmp);
        //test
        //inactivePeriods.add(tmp);
      } else {
        inactivePeriods.add(tmp);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingView),
      child: SizedBox(
        height: Get.height - 60,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).activeMeds,
                    style: Styles.textStyleMedium18.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  GetBuilder<NavController>(
                    init: NavController(),
                    builder: (controller) => IconButton(
                      onPressed: () async {
                        await getRemoteMeds(controller);
                      },
                      icon: const Icon(Icons.refresh_sharp),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            activeMeds.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        S.of(context).noMeds,
                        style: Styles.textStyleBold18,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: Get.height / 2,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: activeMeds.length,
                          itemBuilder: (context, i) {
                            return ActiveMedsItem(
                              isActive: activeMeds[i]['isActive'],
                              id: activeMeds[i]['id'],
                              periods: activePeriods[i],
                              title: activeMeds[i]['name'],
                              subtitle: activeMeds[i]['note'],
                              image: medRepo.medIcon(activeMeds[i]['type']),
                              //periods: periods(activemeds[i]['periods']),
                            );
                          }),
                    ),
                  ),
            SliverToBoxAdapter(
              child: Text(S.of(context).inactiveMeds,
                  style: Styles.textStyleMedium18.copyWith(
                    color: Colors.black.withOpacity(0.5),
                  )),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            inactiveMeds.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        S.of(context).noMeds,
                        style: Styles.textStyleBold18,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: Get.height / 2,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: inactiveMeds.length,
                          itemBuilder: (context, i) {
                            return ActiveMedsItem(
                              isActive: inactiveMeds[i]['isActive'],
                              id: inactiveMeds[i]['id'],
                              periods: inactivePeriods[i],
                              title: inactiveMeds[i]['name'],
                              subtitle: inactiveMeds[i]['note'],
                              image: medRepo.medIcon(inactiveMeds[i]['type']),
                            );
                          }),
                    ),
                  ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 70,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getRemoteMeds(NavController controller) async {
    SqlDb sqlDb = SqlDb();
    sqlDb.deleteAllRows('meds');
    final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    String? cgUid;
    String toUseUid;
    final res =
        await getIt.get<FirebaseFirestore>().collection('users').doc(uid).get();
    if (res.exists) {
      cgUid = res.data()!['cgUid'];
    }
    if (cgUid != null && cgUid.isNotEmpty && cgUid.length >= 28) {
      toUseUid = cgUid;
    } else {
      toUseUid = uid;
    }
    DataSnapshot snapshot;
    try {
      snapshot =
          await getIt.get<FirebaseDatabase>().ref('uMeds/$toUseUid').get();
    } catch (e) {
      snapshot = await getIt.get<FirebaseDatabase>().ref('uMeds/$uid').get();
    }

    if (snapshot.exists) {
      for (var element in snapshot.children) {
        //print(element.value);
        var mp = element.value as Map;
        int response = await sqlDb.insert('meds', {
          'id': mp['id'],
          'name': mp['name'],
          'type': mp['type'],
          'note': mp['note'],
          'periods': mp['periods'],
          'isActive': mp['isActive'],
          'isTaken': mp['isTaken'],
        });
      }
    } else {
      Get.snackbar('Alert!', 'No data available.');
    }
    controller.onItemTapped(3);
    //print(controller.index);
    Future.delayed(const Duration(milliseconds: 50), () {
      controller.onItemTapped(2);
      //print(controller.index);
    });
  }
}
