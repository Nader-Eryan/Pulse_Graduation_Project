import 'package:flutter/material.dart';
import 'package:pulse/Core/utils/styles.dart';

class MealTimeSelector extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const MealTimeSelector({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Styles.textStyleNormal12,
        ),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.none,
          onTap: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then((value) {
              if (value != null) {
                controller.text =
                    '${value.hour}:${value.minute} ${value.period.name}';
              }
            });
          },
          validator: (value) {
            if (value != null) {
              if (value.isEmpty) {
                return 'Time must be available';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Color(0xffE4E4E5), width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff407CE2)),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            filled: true,
            fillColor: const Color(0xffF9FAFB),
            hintText: 'Select Time',
            hintStyle: Styles.textStyleNormal12.copyWith(
              color: const Color(0xff7B7B7B),
            ),
            // prefixIcon: Icon(
            //   Icons.access_time,
            //   color: Colors.grey,
            // ),
          ),
        ),
      ],
    );
  }
}
