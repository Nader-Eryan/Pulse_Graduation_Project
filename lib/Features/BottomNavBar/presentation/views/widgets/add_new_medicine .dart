import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Features/BottomNavBar/presentation/manager/medication_type_controller.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/select_medication_types_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/choose_medicine.dart';
import 'package:pulse/core/utils/sql_database.dart';
import 'package:pulse/core/widgets/custom_appbar.dart';

import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../manager/med_time_controller.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  final typeController = Get.put(MedicationTypeController());
  final timeController = Get.put(MedTimeController());
  List<String> whenList = [
    'Before breakfast',
    'After breakfast',
    'Before lunch',
    'After lunch',
    'Before dinner',
    'After dinner'
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add New Medicine '),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .1,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ChooseMedicine(
                      image: 'assets/images/tablet.png',
                    ),
                    ChooseMedicine(
                      image: 'assets/images/injection.png',
                    ),
                    ChooseMedicine(
                      image: 'assets/images/cream.png',
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const SelectMedicationTypesView());
                  },
                  child: const Text(
                    'See All',
                    style: Styles.textStyleMedium18,
                  )),
              SizedBox(
                height: Get.height * .08,
                child: CustomFormField(
                  isSuffixIcon: false,
                  isPassWord: false,
                  radius: 50.0,
                  hintText: 'Medicine name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: Get.height * .08,
                child: CustomFormField(
                  isSuffixIcon: false,
                  isPassWord: false,
                  radius: 50.0,
                  hintText: 'Extra note (optional)',
                  controller: _noteController,
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'When the drug is taken',
                style: Styles.textStyleBold18,
              ),
              GetBuilder<MedTimeController>(
                init: MedTimeController(),
                builder: (controller) => SizedBox(
                  height: Get.height * .4,
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 3 / 1.5),
                    itemBuilder: (_, int index) {
                      return SizedBox(
                        height: Get.height * 05,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: CheckboxListTile(
                            title: Text(whenList[index]),
                            //subtitle: Text(whenList[index]),
                            value: controller.selectedIndexes.contains(index),
                            onChanged: (_) {
                              if (controller.selectedIndexes.contains(index)) {
                                controller.remove(index); // unselect
                              } else {
                                controller.add(index); // select
                              }
                              setState(() {});
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomMaterialButton(
                text: 'Add Medical',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addMed();
                  }
                },
                screenRatio: 0.9,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addMed() async {
    String periods = '';
    for (var element in timeController.selectedIndexes) {
      periods += element.toString();
    }
    print(periods);
    SqlDb sqlDb = SqlDb();
    int response = await sqlDb.insert('meds', {
      'name': _nameController.text,
      'type': typeController.chosen,
      'note': _noteController.text,
      'periods': periods,
      'isActive': 1,
    });
    if (response > 0) {
      Get.back();
    } else {
      Get.snackbar('Failure', 'Make sure you filled all the needed fields!');
    }
  }
}
