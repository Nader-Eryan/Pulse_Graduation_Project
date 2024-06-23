import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/managers/notification_services.dart';
import 'package:pulse/Features/BottomNavBar/data/repo/fire_repo.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/bottom_nav_bar_views.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/generated/l10n.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/utils/sql_database.dart';

// ignore: must_be_immutable
class ActiveMedsItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final List<String> periods;
  final int id;
  int isActive;
  ActiveMedsItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.periods,
      required this.id,
      required this.isActive})
      : super(key: key);

  @override
  State<ActiveMedsItem> createState() => _ActiveMedsItemState();
}

class _ActiveMedsItemState extends State<ActiveMedsItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(
              widget.image,
              height: Get.height,
              width: Get.width * 0.3,
            ),
            title: Text(
              widget.title,
              style: Styles.textStyleMedium18.copyWith(
                color: Colors.black,
              ),
            ),
            // subtitle: Text(
            //   subtitle,
            //   style: Styles.textStyleNormal12.copyWith(
            //     color: Colors.black.withOpacity(0.5),
            //   ),
            // ),
            subtitle: SizedBox(
              height: widget.periods.length * 17 + 20,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.periods.length + 1,
                  itemBuilder: (context, i) {
                    if (i < widget.periods.length) {
                      return Text(
                        widget.periods[i],
                        style: Styles.textStyleNormal12
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      );
                    } else {
                      return Text(
                        widget.subtitle,
                        style: Styles.textStyleNormal12.copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      );
                    }
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    //print(task.id);
                    final String uid =
                        getIt.get<FirebaseAuth>().currentUser!.uid;

                    final res = await getIt
                        .get<FirebaseFirestore>()
                        .collection('users')
                        .doc(uid)
                        .get();
                    if (res.exists &&
                        res.data()!['role'] != null &&
                        res.data()!['role'] == 'Care receiver') {
                      if (context.mounted) {
                        Get.snackbar(
                            S.of(context).activeMedsItemUnauthorizedEdit,
                            S
                                .of(context)
                                .activeMedsItemChangeRoleInEditProfile);
                      }
                    } else if (mounted) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text(S
                                    .of(context)
                                    .activeMedsItemAreYouSureYouWantToDeleteTheSelectedMed),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                        S.of(context).activeMedsItemCancel),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await _deleteMed(context);
                                      LocalNotificationServices()
                                          .canceledNotificationForMed(
                                              widget.id);
                                    },
                                    child: Text(
                                        S.of(context).activeMedsItemSubmit),
                                  ),
                                ],
                              ));
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 144, 10, 10),
                  )),
              IconButton(
                onPressed: () async {
                  final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;

                  final res = await getIt
                      .get<FirebaseFirestore>()
                      .collection('users')
                      .doc(uid)
                      .get();
                  if (res.exists &&
                      res.data()!['role'] != null &&
                      res.data()!['role'] == 'Care receiver') {
                    if (context.mounted) {
                      Get.snackbar(S.of(context).activeMedsItemUnauthorizedEdit,
                          S.of(context).activeMedsItemChangeRoleInEditProfile);
                    }
                  } else {
                    setState(
                      () {
                        widget.isActive = widget.isActive == 1 ? 0 : 1;
                      },
                    );
                    SqlDb sqlDb = SqlDb();
                    int response = await sqlDb.updateData('''
                                    UPDATE meds SET 'isActive'= ${widget.isActive} WHERE id = ${widget.id}
                                    ''');
                    if (response > 0) {
                      _updateMedRemote(widget.isActive);
                      LocalNotificationServices()
                          .canceledNotificationForMed(widget.id);
                      if (context.mounted) {
                        Get.snackbar(
                            S.of(context).activeMedsItemUpdatedSuccess,
                            S
                                .of(context)
                                .activeMedsItemUpdateAppearsNextTimeYouLoadThePage);
                      }
                    }
                  }
                },
                icon: Icon(
                  widget.isActive == 1
                      ? Icons.done
                      : Icons.unpublished_outlined,
                  color: const Color.fromARGB(255, 6, 81, 8),
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => EditNote(
              //           note: note,
              //         ),
              //       ),
              //     );
              //   },
              //   icon: const Icon(Icons.access_alarm),
              // )
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
          )
        ],
      ),
    );
  }

  Future<void> _deleteMed(BuildContext context) async {
    SqlDb sqlDb = SqlDb();
    FireRepo fireRepo = FireRepo();
    final drugToBeRemoved =
        await sqlDb.readData("SELECT * FROM meds WHERE id == ${widget.id}");

    int response = await sqlDb.deleteData('''
                                   DELETE FROM meds WHERE id = ${widget.id}
                                      ''');
    if (response > 0) {
      Get.back();
      _deleteMedRemote();
      fireRepo.removeMedFromFire(drugToBeRemoved[0]['name']);
      if (context.mounted) {
        Get.snackbar(S.of(context).activeMedsItemDeletedSuccessfully,
            S.of(context).activeMedsItemRefreshToShowChanges);
      }
      Get.off(const BottomNavBarViews());
    }
  }

  void _deleteMedRemote() {
    final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    getIt.get<FirebaseDatabase>().ref('uMeds/$uid/${widget.id}').remove();
  }

  void _updateMedRemote(int isActive) {
    final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    getIt.get<FirebaseDatabase>().ref('uMeds/$uid/${widget.id}').update({
      'isActive': isActive,
    });
  }
}
