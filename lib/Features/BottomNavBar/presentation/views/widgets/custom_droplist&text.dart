import 'package:flutter/material.dart';
import 'package:pulse/Core/utils/styles.dart';

class DropListAndText extends StatefulWidget {
  final List<String> dropdownValues;
  final String hintText;

  const DropListAndText({
    Key? key,
    required this.dropdownValues,
    required this.hintText,
  }) : super(key: key);

  @override
  State<DropListAndText> createState() => _DropListAndTextState();
}

class _DropListAndTextState extends State<DropListAndText> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.hintText,
            style: Styles.textStyleMedium18.copyWith(
              color: const Color(0xFF121212).withOpacity(0.4),
            ),
          ),
          DropdownButton<String>(
            value: value,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (newValue) {
              setState(() {
                value = newValue!;
              });
            },
            elevation: 0,
            underline: Container(),
            items: widget.dropdownValues
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
