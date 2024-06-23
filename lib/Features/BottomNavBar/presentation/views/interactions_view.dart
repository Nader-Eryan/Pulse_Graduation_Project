import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/Profile/presentation/views/widgets/no_int.dart';
import 'package:pulse/core/utils/constants.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/generated/l10n.dart';

class InteractionsView extends StatefulWidget {
  const InteractionsView({super.key});

  @override
  State<InteractionsView> createState() => _InteractionsViewState();
}

class _InteractionsViewState extends State<InteractionsView> {
  String? toUseUid;

  @override
  void initState() {
    getInteractions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).drugDrugInteraction,
              style: Styles.textStyleBold18,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingView),
          child: FutureBuilder<DocumentSnapshot>(
              future: getIt
                  .get<FirebaseFirestore>()
                  .collection('dList')
                  .doc(toUseUid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(S.of(context).somethingWentWrong));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: NoInt());
                }
                try {
                  return Column(
                    children: [
                      Text(S.of(context).interactionText),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: Get.height / 2.2,
                        child: ListView.builder(
                          itemCount: snapshot.data!['interactions'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${snapshot.data!['interactions'][index]['existing_drug']}',
                                            style: Styles.textStyleMedium14,
                                          ),
                                        ),
                                        Icon(
                                          Icons.close,
                                          color: Colors.red[800],
                                          size: 50,
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${snapshot.data!['interactions'][index]['new_drug']}',
                                            style: Styles.textStyleMedium14,
                                          ),
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
                  return const Center(child: NoInt());
                }
              }),
        ),
      ],
    );
  }

  void getInteractions() async {
    String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    String? cgUid;
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
    setState(() {});
  }
}
