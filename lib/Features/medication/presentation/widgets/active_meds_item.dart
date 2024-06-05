import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/styles.dart';

class ActiveMedsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final List<String> periods;
  const ActiveMedsItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.periods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(
              image,
              height: Get.height,
              width: Get.width * 0.3,
            ),
            title: Text(
              title,
              style: Styles.textStyleMedium18.copyWith(
                color: Colors.black,
              ),
            ),
            // subtitle: Text(
            //   subtitle,
            //   style: Styles.textStyleNormal12.copyWith(
            //     color: Colors.black.withOpacity(0.5),
            //   ),
            // ),
            subtitle: SizedBox(
              height: periods.length * 17,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: periods.length + 1,
                  itemBuilder: (context, i) {
                    if (i < periods.length) {
                      return Text(
                        periods[i],
                        style: Styles.textStyleNormal12
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      );
                    } else {
                      return Text(
                        subtitle,
                        style: Styles.textStyleNormal12.copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      );
                    }
                  }),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
