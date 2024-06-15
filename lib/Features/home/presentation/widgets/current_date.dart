import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/constants.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class CurrentDate extends StatefulWidget {
  const CurrentDate({Key? key}) : super(key: key);

  @override
  State<CurrentDate> createState() => _CurrentDateState();
}

class _CurrentDateState extends State<CurrentDate> {
  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: Get.height * .22 - Get.height * .13,
    //   width: Get.width,
    //   child: ListView.separated(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 7,
    //     itemBuilder: (context, index) => Container(
    //       padding: const EdgeInsetsDirectional.all(10.0),
    //       width: Get.width * .15,
    //       height: Get.height * .1,
    //       decoration: BoxDecoration(
    //         color: index == 0 ? const Color(0xff407CE2) : Colors.white,
    //         borderRadius: BorderRadius.circular(15.0),
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             DateFormat('EEE')
    //                 .format(DateTime.now().add(Duration(days: index))),
    //             style: Styles.textStyleNormal12.copyWith(
    //               color: index == 0 ? Colors.white : Colors.black,
    //             ),
    //           ),
    //           Text(
    //             DateFormat('d')
    //                 .format(DateTime.now().add(Duration(days: index))),
    //             style: Styles.textStyleNormal12.copyWith(
    //               color: index == 0 ? Colors.white : Colors.black,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     separatorBuilder: (context, index) => const SizedBox(width: 10.0),
    //   ),
    // );
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: kPrimaryColor,
      height: Get.height / 9,
      daysCount: 7,
      selectedTextColor: Colors.white,
      locale: Localizations.localeOf(context).languageCode,
      onDateChange: (date) {
        // New date selected
        setState(() {
          // _selectedValue = date;
        });
      },
    );
  }
}
