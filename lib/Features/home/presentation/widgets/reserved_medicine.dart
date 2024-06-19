import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/styles.dart';

class ReservedMedicine extends StatelessWidget {
  final bool isTaken;
  final String medName;
  final String frequency;
  const ReservedMedicine({
    super.key,
    required this.isTaken,
    required this.medName,
    required this.frequency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .12,
      decoration: BoxDecoration(
        color: const Color(0xffF5F8FC),
        border: Border.all(
            color: const Color(0xff221F1F).withOpacity(0.2), width: 0.5),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: ListTile(
          leading: Image.asset(
            'assets/images/inhaler.png',
            width: Get.width * 0.15,
            height: Get.height * 0.15,
            fit: BoxFit.scaleDown,
          ),
          title: Text(
            medName,
            style: Styles.textStyleSemiBold16,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            children: [
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
                  ? Icon(Icons.check,
                      color: Colors.green, size: Get.width * 0.06)
                  : Icon(FontAwesomeIcons.exclamation,
                      color: Colors.red, size: Get.width * 0.05),
            ),
          ),
        ),
      ),
    );
  }
}
