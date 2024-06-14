class MedRepo {
  List<String> medPeriod(String period) {
    String pString = period;
    List<String> periods = [];
    if (pString.contains('0')) {
      periods.add('Before breakfast');
    }
    if (pString.contains('1')) {
      periods.add('After breakfast');
    }
    if (pString.contains('2')) {
      periods.add('Before lunch');
    }
    if (pString.contains('3')) {
      periods.add('After lunch');
    }
    if (pString.contains('4')) {
      periods.add('Before dinner');
    }
    if (pString.contains('5')) {
      periods.add('After dinner');
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
