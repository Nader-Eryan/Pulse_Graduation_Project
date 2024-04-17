import 'package:flutter/material.dart';

class MedicationTimeSelection extends StatefulWidget {
  const MedicationTimeSelection({super.key});

  @override
  State<MedicationTimeSelection> createState() =>
      _MedicationTimeSelectionState();
}

class _MedicationTimeSelectionState extends State<MedicationTimeSelection> {
  Map<String, bool> values = {
    'Before breakfast': false,
    'After breakfast': false,
    'Before lunch': false,
    'After lunch': false,
    'Before dinner': false,
    'After dinner': false,
  };

  Widget buildCheckbox(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: values[title],
          onChanged: (value) {
            setState(() {
              values[title] = value!;
            });
          },
          activeColor: const Color(0xff407CE2),
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          shape: const CircleBorder(),
        ),
        Text(
          title,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCheckbox('Before breakfast'),
            buildCheckbox('Before lunch'),
            buildCheckbox('Before dinner'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCheckbox('After breakfast'),
            buildCheckbox('After lunch'),
            buildCheckbox('After dinner'),
          ],
        ),
      ],
    );
  }
}
