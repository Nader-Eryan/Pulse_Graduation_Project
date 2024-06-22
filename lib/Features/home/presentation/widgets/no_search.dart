import 'package:flutter/material.dart';
import 'package:pulse/core/utils/styles.dart';

class NoSearch extends StatelessWidget {
  const NoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text('Enter a med to get alternatives',
                style: Styles.textStyleNormal16),
          ),
        ),
      ],
    ));
  }
}
