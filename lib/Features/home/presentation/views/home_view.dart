import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Features/home/presentation/widgets/current_date.dart';
import 'package:pulse/Features/home/presentation/widgets/refill_drugs&pill_box_circle.dart';
import 'package:pulse/Features/home/presentation/widgets/reserved_medicine.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/core/widgets/custom_text_form_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                    const Text('Welcome!', style: Styles.textStyleNormal14),
                    const SizedBox(width: 10.0),
                    const Text('Sarah', style: Styles.textStyleSemiBold14),
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
                      hintText: 'Search drugs',
                      controller: TextEditingController(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      prefixIcon: FontAwesomeIcons.magnifyingGlass,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RefillDrugsPillBoxCircle(
                          text: 'Refill Drugs',
                          image: 'assets/images/refill drugs.svg',
                        ),
                        RefillDrugsPillBoxCircle(
                          text: 'Pill Box',
                          image: 'assets/images/unselected_medication.svg',
                        ),
                      ]),
                  const SizedBox(height: 30.0),
                  const Text('Selected day’s meds',
                      style: Styles.textStyleSemiBold16),
                  const SizedBox(height: 20.0),
                  const ReservedMedicine(
                    isTaken: true,
                    text: 'Paracetamol',
                    image: 'assets/images/tablet.png',
                    medicationTime: '10:00 AM',
                    date: '02/12/2022',
                    frequency: '2x/day',
                  ),
                  SizedBox(height: Get.height * .01),
                  const ReservedMedicine(
                    isTaken: false,
                    text: 'Paracetamol',
                    image: 'assets/images/tablet.png',
                    medicationTime: '10:00 AM',
                    date: '02/12/2022',
                    frequency: 'weekly',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
