import 'package:flutter/material.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/generated/l10n.dart';

class NoInt extends StatelessWidget {
  const NoInt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).awesome,
              style: Styles.textStyleBold22.copyWith(color: Colors.green[800]),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.check,
              size: 40,
              color: Colors.green,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          S.of(context).noInteractionText,
          style: Styles.textStyleMedium18.copyWith(color: Colors.green[800]),
        ),
      ]),
    );
  }
}
