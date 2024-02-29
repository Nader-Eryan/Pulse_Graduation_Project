import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulse/Core/utils/styles.dart';

class BottomNavBarItem extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final String title;
  final String selectedIcon;
  final String unSelectedIcon;
  const BottomNavBarItem({
    super.key,
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          padding: const EdgeInsetsDirectional.all(0.0),
          icon: SvgPicture.asset(
            isSelected ? selectedIcon : unSelectedIcon,
          ),
          onPressed: onTap,
        ),
        Text(
          isSelected ? title : '',
          style: isSelected
              ? Styles.textStyleMedium12
                  .copyWith(color: const Color(0xff407CE2))
              : Styles.textStyleMedium12
                  .copyWith(color: const Color(0xff221F1F).withOpacity(0.6)),
        )
      ],
    );
  }
}
