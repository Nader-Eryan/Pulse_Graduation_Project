import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/styles.dart';

class ActiveMedsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  const ActiveMedsItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(
              image,
              height: Get.height,
              width: Get.width * 0.3,
              // fit:  BoxFit.cover,
              // filterQuality: FilterQuality.high,
            ),
            title: Text(
              title,
              style: Styles.textStyleMedium18.copyWith(
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: Styles.textStyleNormal12.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
            )),
        const Divider(
          color: Colors.black,
          thickness: 0.5,
        )
      ],
    );
  }
}
