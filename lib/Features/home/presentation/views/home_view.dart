import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Features/Box/presentation/pill_box.dart';
import 'package:pulse/Features/home/presentation/widgets/current_date.dart';
import 'package:pulse/Features/home/presentation/widgets/refill_drugs&pill_box_circle.dart';
import 'package:pulse/Features/home/presentation/widgets/reserved_medicine.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/core/widgets/custom_text_form_field.dart';
import 'package:pulse/generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userName = '';
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
                  SizedBox(
                    height: Get.height * .06,
                    child: CustomFormField(
                      isSuffixIcon: false,
                      isPassWord: false,
                      radius: 50.0,
                      hintText: S.of(context).searchDrugs,
                      controller: TextEditingController(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).pleaseEnterSomeText;
                        }
                        return null;
                      },
                      prefixIcon: FontAwesomeIcons.magnifyingGlass,
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                  const SizedBox(height: 30.0),
                  Text(S.of(context).selectedDaysMeds,
                      style: Styles.textStyleSemiBold16),
                  const SizedBox(height: 20.0),
                  ReservedMedicine(
                    isTaken: true,
                    text: S.of(context).paracetamol,
                    image: 'assets/images/tablet.png',
                    medicationTime: S.of(context).medicationTime,
                    date: S.of(context).date,
                    frequency: S.of(context).frequency,
                  ),
                  SizedBox(height: Get.height * .01),
                  ReservedMedicine(
                    isTaken: false,
                    text: S.of(context).paracetamol,
                    image: 'assets/images/tablet.png',
                    medicationTime: S.of(context).medicationTime,
                    date: S.of(context).date,
                    frequency: S.of(context).weekly,
                  ),
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
}
