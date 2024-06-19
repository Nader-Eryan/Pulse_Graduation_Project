import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/Profile/presentation/views/widgets/no_int.dart';
import 'package:pulse/core/utils/constants.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/styles.dart';

class InteractionsView extends StatefulWidget {
  const InteractionsView({super.key});

  @override
  State<InteractionsView> createState() => _InteractionsViewState();
}

class _InteractionsViewState extends State<InteractionsView> {
  String uid = getIt.get<FirebaseAuth>().currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Drug-drug interaction',
              style: Styles.textStyleBold22,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingView),
          child: FutureBuilder<DocumentSnapshot>(
              future: getIt
                  .get<FirebaseFirestore>()
                  .collection('dList')
                  .doc(uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  const Center(child: NoInt());
                }
                try {
                  return Column(
                    children: [
                      Text(
                        '''Our algorithims discovered that there are bad interactions between the following drugs.\nRefer back to your doctor with these results!''',
                        style: Styles.textStyleMedium18
                            .copyWith(color: Colors.red[900]),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: Get.height / 2,
                        child: ListView.builder(
                          itemCount: snapshot.data!['interactions'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Flexible(
                              child: Card(
                                child: Center(
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${snapshot.data!['interactions'][index]['existing_drug']} '
                                                .toString(),
                                            style: Styles.textStyleBold18,
                                          ),
                                          Icon(
                                            Icons.close,
                                            color: Colors.red[800],
                                            size: 60,
                                          ),
                                          Text(
                                            '  ${snapshot.data!['interactions'][index]['new_drug']}'
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: Styles.textStyleBold18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
}
