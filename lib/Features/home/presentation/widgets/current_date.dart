import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pulse/core/utils/styles.dart';

class CurrentDate extends StatelessWidget {
  const CurrentDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .22 - Get.height * .13,
      width: Get.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsetsDirectional.all(10.0),
          width: Get.width * .15,
          height: Get.height * .1,
          decoration: BoxDecoration(
            color: index == 0 ? const Color(0xff407CE2) : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE')
                    .format(DateTime.now().add(Duration(days: index))),
                style: Styles.textStyleNormal12.copyWith(
                  color: index == 0 ? Colors.white : Colors.black,
                ),
              ),
              Text(
                DateFormat('d')
                    .format(DateTime.now().add(Duration(days: index))),
                style: Styles.textStyleNormal12.copyWith(
                  color: index == 0 ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
      ),
    );
  }
}
