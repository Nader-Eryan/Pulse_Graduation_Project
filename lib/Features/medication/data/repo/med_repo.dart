import 'package:flutter/src/widgets/framework.dart';
import 'package:pulse/generated/l10n.dart';

class MedRepo {
  BuildContext context;
  MedRepo({required this.context});
  List<String> medPeriod(String period) {
    String pString = period;
    List<String> periods = [];
    if (pString.contains('0')) {
      periods.add(S.of(context).beforeBreakfast);
    }
    if (pString.contains('1')) {
      periods.add(S.of(context).afterBreakfast);
    }
    if (pString.contains('2')) {
      periods.add(S.of(context).beforeLunch);
    }
    if (pString.contains('3')) {
      periods.add(S.of(context).afterLunch);
    }
    if (pString.contains('4')) {
      periods.add(S.of(context).beforeDinner);
    }
    if (pString.contains('5')) {
      periods.add(S.of(context).afterDinner);
    }
    return periods;
  }

  String medIcon(String type) {
    switch (type) {
      case 'Drop':
        return 'assets/images/drop.png';
      case 'Cream':
        return 'assets/images/cream.png';
      case 'Injection':
        return 'assets/images/injection.png';
      case 'Inhaler':
        return 'assets/images/inhaler.png';
      case 'Solution':
        return 'assets/images/solution.png';
      case 'Spray':
        return 'assets/images/spray.png';
      case 'Tablet':
        return 'assets/images/tablet.png';
      default:
        return 'assets/images/tablet.png';
    }
  }
}
