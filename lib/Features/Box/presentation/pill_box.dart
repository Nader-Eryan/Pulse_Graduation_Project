import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/core/utils/constants.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/widgets/custom_appbar.dart';
import 'package:pulse/core/widgets/custom_material_button.dart';
import 'package:firebase_database/firebase_database.dart';

class PillBoxView extends StatelessWidget {
  PillBoxView({super.key});
  final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'drug box',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingView),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Open box request:',
                textAlign: TextAlign.start,
                style: Styles.textStyleBold22,
              ),
              CustomMaterialButton(
                  text: 'As a patient',
                  onPressed: () {
                    getIt.get<FirebaseDatabase>().ref(uid).set({"emb": 1});
                  },
                  screenRatio: 0.9),
              CustomMaterialButton(
                  text: 'As a Care giver',
                  onPressed: () {
                    getIt.get<FirebaseDatabase>().ref(uid).set({"emb": 2});
                  },
                  screenRatio: 0.9),
              CustomMaterialButton(
                  text: 'Close box',
                  onPressed: () {
                    getIt.get<FirebaseDatabase>().ref(uid).set({"emb": 0});
                  },
                  screenRatio: 0.9),
            ],
          ),
        ),
      ),
    );
  }
}
