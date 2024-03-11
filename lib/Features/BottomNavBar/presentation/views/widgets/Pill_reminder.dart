import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pulse/Core/utils/styles.dart';

class PillReminder extends StatelessWidget {
  const PillReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.15,
        width: double.infinity * 0.8,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFEBEEFA).withOpacity(0.5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PillStatus(
              isTaken: false,
              index: 0,
            ),
            PillStatus(
              isTaken: true,
              index: 1,
            ),
            PillStatus(
              isTaken: true,
              index: 2,
            ),
            PillStatus(
              isTaken: false,
              index: 3,
            ),
            PillStatus(
              isTaken: false,
              index: 4,
            ),
            PillStatus(
              isTaken: false,
              index: 5,
            ),
            PillStatus(
              isTaken: false,
              index: 6,
            ),
          ],
        )
        // child: ListView.separated(
        //   scrollDirection: Axis.horizontal,
        //   itemCount: 7,
        //   itemBuilder: (context, index) {
        //     return Column(
        //       children: [
        //         Text(
        //           DateFormat('EEE')
        //               .format(currentDate.add(Duration(days: index))),
        //           style: Styles.textStyleNormal16,
        //         ),
        //         CircleAvatar(
        //           radius: 21,
        //           backgroundColor: Colors.black.withOpacity(0.2),
        //           child: CircleAvatar(
        //             backgroundColor: const Color(0xffF0F3FB),
        //             child: isTaken
        //                 ? const Icon(Icons.check, color: Colors.green)
        //                 : const Icon(Icons.error, color: Colors.red),
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        //   separatorBuilder: (context, index) => SizedBox(width: Get.width * 0.03),
        // ),
        );
  }
}

class PillStatus extends StatelessWidget {
  // final DateTime currentDate;
  final bool isTaken;
  final int index;
  const PillStatus({
    super.key,
    required this.isTaken,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat('EEE').format(DateTime.now().add(Duration(days: index))),
          style: Styles.textStyleNormal16,
        ),
        const SizedBox(height: 5),
        CircleAvatar(
          radius: Get.width * 0.035,
          backgroundColor: isTaken ? Colors.green : Colors.red,
          child: CircleAvatar(
            radius: Get.width * 0.03,
            backgroundColor: const Color(0xffF0F3FB),
            child: isTaken
                ? Icon(Icons.check, color: Colors.green, size: Get.width * 0.06)
                : Icon(FontAwesomeIcons.exclamation,
                    color: Colors.red, size: Get.width * 0.05),
          ),
        )
      ],
    );
  }
}
