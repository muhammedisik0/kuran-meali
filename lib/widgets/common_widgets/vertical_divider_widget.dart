import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class IVerticalDivider extends StatelessWidget {
  const IVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      width: 0,
      color: ColorConstants.white,
      thickness: 1,
    );
  }
}
