import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/select_medication_types_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/custom_droplist&text.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/choose_medicine.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/medication_time_selection_checkbox.dart';
import 'package:pulse/core/widgets/custom_text_form_field.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff407CE2).withOpacity(0.7),
      shape: const CircleBorder(),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: Get.height * .8,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Add New Medicine ',
                      style: Styles.textStyleSemiBold20,
                    ),
                    SizedBox(height: Get.height * .03),
                    const Row(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(() => const SelectMedicationTypesView());
                            },
                            child: const Text('See All')),
                      ],
                    ),
                    const MedicationTimeSelection(),
                    SizedBox(height: Get.height * .02),
                    SizedBox(
                      height: Get.height * .08,
                      child: CustomFormField(
                        isSuffixIcon: false,
                        isPassWord: false,
                        radius: 50.0,
                        hintText: 'Medicine Name',
                        controller: TextEditingController(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: Get.height * .02),
                    const DropListAndText(
                      dropdownValues: ['1', '2', '3'],
                      hintText: 'Dose',
                    ),
                    SizedBox(height: Get.height * .02),
                    const DropListAndText(
                      dropdownValues: ['Daily', 'Weekly', 'Monthly'],
                      hintText: 'Frequency',
                    ),
                    SizedBox(height: Get.height * .02),
                    CustomMaterialButton(
                      text: 'Add Medical',
                      onPressed: () {},
                      screenRatio: 0.9,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
