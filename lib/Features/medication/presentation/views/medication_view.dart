import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Features/medication/presentation/widgets/active_meds_item.dart';
import 'package:pulse/core/utils/sql_database.dart';
import 'package:pulse/core/utils/styles.dart';

class MedicationView extends StatefulWidget {
  const MedicationView({super.key});

  @override
  State<MedicationView> createState() => _MedicationViewState();
}

List<Map> activeMeds = [];
List<Map> inactiveMeds = [];
List<List<String>> activePeriods = [];
List<List<String>> inactivePeriods = [];

class _MedicationViewState extends State<MedicationView> {
  @override
  void initState() {
    super.initState();
    raedMeds();
  }

  void raedMeds() async {
    SqlDb sqlDb = SqlDb();
    activeMeds = [];
    inactiveMeds = [];
    activePeriods = [];
    inactivePeriods = [];
    activeMeds.addAll(await sqlDb.read('meds'));
    ////test
    //inactiveMeds.addAll(await sqlDb.read('meds'));
    for (var element in activeMeds) {
      List<String> tmp = medPeriod(element['periods']);
      if (element['isActive'] == 1) {
        activePeriods.add(tmp);
        //test
        //inactivePeriods.add(tmp);
      } else {
        inactivePeriods.add(tmp);
      }
    }
    for (var element in activeMeds) {
      if (element['isActive'] != 1) {
        activeMeds.removeWhere((item) {
          return item['id'] == element['id'];
        });
        inactiveMeds.add(element);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingView),
      child: SizedBox(
        height: Get.height - 60,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Text('Active meds',
                  style: Styles.textStyleMedium18.copyWith(
                    color: Colors.black.withOpacity(0.5),
                  )),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            activeMeds.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No meds to Present',
                        style: Styles.textStyleBold18,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: Get.height / 2,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: activeMeds.length,
                          itemBuilder: (context, i) {
                            return ActiveMedsItem(
                              periods: activePeriods[i],
                              title: activeMeds[i]['name'],
                              subtitle: activeMeds[i]['note'],
                              image: medIcon(activeMeds[i]['type']),
                              //periods: periods(activemeds[i]['periods']),
                            );
                          }),
                    ),
                  ),
            SliverToBoxAdapter(
              child: Text('Inactive meds',
                  style: Styles.textStyleMedium18.copyWith(
                    color: Colors.black.withOpacity(0.5),
                  )),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            inactiveMeds.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No meds to Present',
                        style: Styles.textStyleBold18,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: Get.height / 2,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: inactiveMeds.length,
                          itemBuilder: (context, i) {
                            return ActiveMedsItem(
                              periods: inactivePeriods[i],
                              title: inactiveMeds[i]['name'],
                              subtitle: inactiveMeds[i]['note'],
                              image: medIcon(inactiveMeds[i]['type']),
                            );
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  String medIcon(String type) {
    switch (type) {
      case 'Drop':
        return 'assets/images/drop.png';
      case 'Cream':
        return 'assets/images/cream.png';
      case 'Injection':
        return 'assets/images/injection.png';
      case 'Inhaler':
        return 'assets/images/inhaler.png';
      case 'Solution':
        return 'assets/images/solution.png';
      case 'Spray':
        return 'assets/images/spray.png';
      case 'Tablet':
        return 'assets/images/tablet.png';
      default:
        return 'assets/images/tablet.png';
    }
  }

  List<String> medPeriod(String period) {
    String pString = period;
    List<String> periods = [];
    if (pString.contains('0')) {
      periods.add('Before breakfast');
    }
    if (pString.contains('1')) {
      periods.add('After breakfast');
    }
    if (pString.contains('2')) {
      periods.add('Before lunch');
    }
    if (pString.contains('3')) {
      periods.add('After lunch');
    }
    if (pString.contains('4')) {
      periods.add('Before dinner');
    }
    if (pString.contains('5')) {
      periods.add('After dinner');
    }
    return periods;
  }
}
