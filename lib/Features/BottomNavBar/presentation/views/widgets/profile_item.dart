import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';

class ProfileItem extends StatelessWidget {
  final String text;
  final String icon;
  final void Function()? onTap;
  const ProfileItem(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: Get.width * .06,
            backgroundColor:
                const Color(0xff407CE2).withGreen(200).withOpacity(0.3),
            child: SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(
                Color(0xff407CE2),
                BlendMode.srcIn,
              ),
              height: Get.height * .03,
            ),
          ),
          title: Text(
            text,
            style: Styles.textStyleSemiBold16,
          ),
          trailing: InkWell(
            onTap: onTap,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const Icon(Icons.arrow_forward_ios_rounded),
          )),
      SizedBox(
        height: Get.height * .01,
      ),
      Divider(
        endIndent: 10.0,
        indent: 10.0,
        thickness: 1,
        color: const Color(0xff407CE2).withOpacity(0.15),
      ),
    ]);
  }
}
