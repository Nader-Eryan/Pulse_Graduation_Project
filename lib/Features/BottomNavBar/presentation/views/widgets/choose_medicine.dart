import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseMedicine extends StatelessWidget {
  final String image;

  const ChooseMedicine({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          height: Get.height * .12,
          width: Get.width * .25,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: const Color(0xff407CE2),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff407CE2).withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 35,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Image.asset(
            image,
            // fit: BoxFit.cover,
          ),
        ),
        // isChecked
        //     ? const CircleAvatar(
        //         radius: 12.0,
        //         backgroundColor: Color(0xff407CE2),
        //         child: Icon(
        //           Icons.check,
        //           size: 17.0,
        //           color: Colors.white,
        //         ),
        //       )
        //     : Container(),
      ],
    );
  }
}
