import 'package:flutter/material.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/pill_reminder.dart';

class DrugHistory extends StatelessWidget {
  const DrugHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(
          title: 'Drug History',
        ),
        body: Padding(
          padding: EdgeInsets.all(kPaddingView),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [PillReminder()],
          ),
        ));
  }
}
