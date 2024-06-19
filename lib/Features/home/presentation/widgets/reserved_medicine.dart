import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/styles.dart';

class ReservedMedicine extends StatelessWidget {
  final bool isTaken;
  final String text;
  final String image;
  final String date;
  final String frequency;
  final String medicationTime;
  const ReservedMedicine(
      {super.key,
      required this.isTaken,
      required this.text,
      required this.image,
      required this.date,
      required this.frequency,
      required this.medicationTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .11,
      decoration: BoxDecoration(
        color: const Color(0xffF5F8FC),
        border: Border.all(
            color: const Color(0xff221F1F).withOpacity(0.2), width: 0.5),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ListTile(
        leading: Image.asset(
          image,
          width: Get.width * 0.15,
          height: Get.height * 0.15,
          fit: BoxFit.scaleDown,
        ),
        title: Text(
          '$text\n$medicationTime',
          style: Styles.textStyleSemiBold16,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Text(
              date,
              style: Styles.textStyleMedium12.copyWith(
                color: const Color(0xff221F1F).withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              frequency,
              style: Styles.textStyleMedium12.copyWith(
                color: const Color(0xff221F1F).withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: CircleAvatar(
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
        ),
      ),
    );
  }
}
