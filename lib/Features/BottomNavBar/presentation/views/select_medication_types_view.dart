import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
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
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.start,
            spacing: Get.width * 0.05,
            runSpacing: Get.height * 0.015,
            children: const [
              MedicationTypes(
                image: 'assets/images/tablet.png',
                title: 'Tablet',
              ),
              MedicationTypes(
                image: 'assets/images/drop.png',
                title: 'Drop',
              ),
              MedicationTypes(
                image: 'assets/images/cream.png',
                title: 'Cream',
              ),
              MedicationTypes(
                image: 'assets/images/solution.png',
                title: 'Solution',
              ),
              MedicationTypes(
                image: 'assets/images/injection.png',
                title: 'Injection',
              ),
              MedicationTypes(
                image: 'assets/images/inhaler.png',
                title: 'Inhaler',
              ),
              MedicationTypes(
                image: 'assets/images/spray.png',
                title: 'Spray',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
