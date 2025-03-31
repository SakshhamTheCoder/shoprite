import 'package:flutter/material.dart';
import 'package:shoprite/constants/colors.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key, this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        text: 'Shop',
        style: textTheme.displayMedium?.copyWith(
          color: kSecondaryColor,
          fontSize: size,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Rite',
            style: textTheme.displayMedium?.copyWith(
              color: kPrimaryColor,
              fontSize: size,
            ),
          ),
        ],
      ),
    );
  }
}
