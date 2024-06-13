// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/authentication/data/repo/auth_repo.dart';
import 'package:pulse/Features/authentication/presentation/manager/sign_up_controller.dart';
import 'package:pulse/generated/l10n.dart';

class AgreementCheckbox extends StatelessWidget {
  const AgreementCheckbox({
    Key? key,
    required this.profileRepo,
  }) : super(key: key);
  final AuthRepo profileRepo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GetBuilder(
          init: SignUpController(),
          builder: (controller) => Checkbox(
            value: controller.isChecked,
            onChanged: (value) {
              controller.changeCheckBox();
            },
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: S.of(context).iAgreeToThe,
                  style: Styles.textStyleNormal14,
                ),
                TextSpan(
                  text: S.of(context).privacyPolicy,
                  style: Styles.textStyleNormal14.copyWith(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      profileRepo.urlLauncher(
                          'https://github.com/Nader-Eryan/-_privacy_policy/tree/main');
                    },
                ),
                TextSpan(
                  text: S.of(context).app_name,
                  style: Styles.textStyleSemiBold16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
