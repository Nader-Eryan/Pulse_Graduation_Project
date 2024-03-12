import 'package:flutter/material.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Features/medication/presentation/widgets/active_meds_item.dart';
import 'package:pulse/core/utils/styles.dart';

class MedicationView extends StatelessWidget {
  const MedicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingView),
      child: Column(
        children: <Widget>[
          Text('Active meds',
              style: Styles.textStyleMedium18.copyWith(
                color: Colors.black.withOpacity(0.5),
              )),
          const SizedBox(
            height: 20,
          ),
          const ActiveMedsItem(
            title: 'Aspirin',
            subtitle: '12/12/2022',
            image: 'assets/images/tablet.png',
          ),
        ],
      ),
    );
  }
}
