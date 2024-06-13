import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Features/BottomNavBar/presentation/manager/medication_type_controller.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/medication_types.dart';
import 'package:pulse/generated/l10n.dart';

class SelectMedicationTypesView extends StatelessWidget {
  const SelectMedicationTypesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).medicationTypes,
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
                    child: MedicationTypes(
                      image: 'assets/images/tablet.png',
                      title: S.of(context).tablet,
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
                    child: MedicationTypes(
                      image: 'assets/images/drop.png',
                      title: S.of(context).drop,
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
                    child: MedicationTypes(
                      image: 'assets/images/cream.png',
                      title: S.of(context).cream,
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
                    child: MedicationTypes(
                      image: 'assets/images/solution.png',
                      title: S.of(context).solution,
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
                    child: MedicationTypes(
                      image: 'assets/images/injection.png',
                      title: S.of(context).injection,
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
                    child: MedicationTypes(
                      image: 'assets/images/inhaler.png',
                      title: S.of(context).inhaler,
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
                    child: MedicationTypes(
                      image: 'assets/images/spray.png',
                      title: S.of(context).spray,
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
