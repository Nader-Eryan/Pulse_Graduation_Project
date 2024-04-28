import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/select_medication_types_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/choose_medicine.dart';
import 'package:pulse/core/widgets/custom_text_form_field.dart';

import '../../manager/med_time_controller.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  List<String> whenList = [
    'Before breakfast',
    'After breakfast',
    'Before lunch',
    'After lunch',
    'Before dinner',
    'After dinner'
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff407CE2).withOpacity(0.7),
      shape: const CircleBorder(),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // add this line
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Add New Medicine ',
                    style: Styles.textStyleSemiBold20,
                  ),
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
                      controller: TextEditingController(),
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
                      hintText: 'Extra note',
                      controller: TextEditingController(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
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
                      height: Get.height * .2,
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
                                value:
                                    controller.selectedIndexes.contains(index),
                                onChanged: (_) {
                                  if (controller.selectedIndexes
                                      .contains(index)) {
                                    controller.remove(index); // unselect
                                  } else {
                                    controller.add(index); // select
                                  }
                                  setState(() {});
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  CustomMaterialButton(
                    text: 'Add Medical',
                    onPressed: () {},
                    screenRatio: 0.9,
                  ),
                ],
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
