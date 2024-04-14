import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Features/BottomNavBar/presentation/manager/medication_type_controller.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/medication_types.dart';

class SelectMedicationTypesView extends StatelessWidget {
  const SelectMedicationTypesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Medication Types',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<MedicationTypeController>(
            init: MedicationTypeController(),
            builder: (controller) => Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              spacing: Get.width * 0.05,
              runSpacing: Get.height * 0.015,
              children: [
                InkWell(
                  onTap: () {
                    controller.updateChosen('Tablet');
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    decoration: controller.chosen == 'Tablet'
                        ? chosenMedDecoration()
                        : null,
                    child: const MedicationTypes(
                      image: 'assets/images/tablet.png',
                      title: 'Tablet',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.updateChosen('Drop');
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    decoration: controller.chosen == 'Drop'
                        ? chosenMedDecoration()
                        : null,
                    child: const MedicationTypes(
                      image: 'assets/images/drop.png',
                      title: 'Drop',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.updateChosen('Cream');
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    decoration: controller.chosen == 'Cream'
                        ? chosenMedDecoration()
                        : null,
                    child: const MedicationTypes(
                      image: 'assets/images/cream.png',
                      title: 'Cream',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.updateChosen('Solution');
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    decoration: controller.chosen == 'Solution'
                        ? chosenMedDecoration()
                        : null,
                    child: const MedicationTypes(
                      image: 'assets/images/solution.png',
                      title: 'Solution',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.updateChosen('Injection');
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    decoration: controller.chosen == 'Injection'
                        ? chosenMedDecoration()
                        : null,
                    child: const MedicationTypes(
                      image: 'assets/images/injection.png',
                      title: 'Injection',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.updateChosen('Inhaler');
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    decoration: controller.chosen == 'Inhaler'
                        ? chosenMedDecoration()
                        : null,
                    child: const MedicationTypes(
                      image: 'assets/images/inhaler.png',
                      title: 'Inhaler',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.updateChosen('Spray');
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    decoration: controller.chosen == 'Spray'
                        ? chosenMedDecoration()
                        : null,
                    child: const MedicationTypes(
                      image: 'assets/images/spray.png',
                      title: 'Spray',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration chosenMedDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xff407CE2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff407CE2).withOpacity(0.4),
            spreadRadius: 4,
            blurRadius: 35,
            offset: const Offset(0, 3),
          ),
        ]);
  }
}
