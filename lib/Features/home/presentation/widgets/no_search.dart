import 'package:flutter/material.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/generated/l10n.dart';

class NoSearch extends StatelessWidget {
  const NoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(S.of(context).enterAMedToGetAlternatives,
                style: Styles.textStyleNormal16),
          ),
        ),
      ],
    ));
  }
}
