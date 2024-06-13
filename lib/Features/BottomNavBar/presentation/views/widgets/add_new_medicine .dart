import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Features/BottomNavBar/presentation/manager/medication_type_controller.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/select_medication_types_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/choose_medicine.dart';
import 'package:pulse/core/utils/sql_database.dart';
import 'package:pulse/core/widgets/custom_appbar.dart';
import 'package:pulse/generated/l10n.dart';

import '../../../../../core/utils/service_locator.dart';
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    List<String> whenList = [
      S.of(context).beforeBreakfast,
      S.of(context).afterBreakfast,
      S.of(context).beforeLunch,
      S.of(context).afterLunch,
      S.of(context).beforeDinner,
      S.of(context).afterDinner
    ];
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).addMedication),
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
                  child: Text(
                    S.of(context).seeAll,
                    style: Styles.textStyleMedium18,
                  )),
              SizedBox(
                height: Get.height * .08,
                child: CustomFormField(
                  isSuffixIcon: false,
                  isPassWord: false,
                  radius: 50.0,
                  hintText: S.of(context).medicineName,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterSomeText;
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
                  hintText: S.of(context).extraNoteOptional,
                  controller: _noteController,
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                S.of(context).whenTheDrugIsTaken,
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
                text: S.of(context).addMedication,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addMedLocal();
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

  SqlDb sqlDb = SqlDb();
  Future<void> addMedLocal() async {
    String periods = '';
    for (var element in timeController.selectedIndexes) {
      periods += element.toString();
    }
    //print(periods);
    int response = await sqlDb.insert('meds', {
      'name': _nameController.text,
      'type': typeController.chosen,
      'note': _noteController.text,
      'periods': periods,
      'isActive': 1,
      'isTaken': 1,
    });
    if (response > 0) {
      Get.back();
      addMedRemote(response, periods);
    } else {
      Get.snackbar(S.of(context).failure,
          S.of(context).makeSureYouFilledAllTheNeededFields);
    }
  }

  void addMedRemote(int id, String periods) {
    final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    getIt.get<FirebaseDatabase>().ref('uMeds/$uid/$id').set({
      'name': _nameController.text,
      'type': typeController.chosen,
      'note': _noteController.text,
      'periods': periods,
      'isActive': 1,
      'isTaken': 1,
    });
  }
}
