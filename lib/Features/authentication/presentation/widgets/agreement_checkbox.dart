import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pulse/Core/utils/styles.dart';

class AgreementCheckbox extends StatefulWidget {
  const AgreementCheckbox({super.key});

  @override
  State<AgreementCheckbox> createState() => _AgreementCheckboxState();
}

class _AgreementCheckboxState extends State<AgreementCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(
                    text: 'I agree to the healthcare ',
                    style: Styles.textStyleNormal14),
                TextSpan(
                  text: 'Terms of Service',
                  style: Styles.textStyleNormal14.copyWith(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' and ', style: Styles.textStyleNormal14),
                TextSpan(
                  text: 'Privacy Policy',
                  style: Styles.textStyleNormal14.copyWith(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


