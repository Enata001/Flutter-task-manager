import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/dimensions.dart';

class CElevatedButton extends StatelessWidget {
  const CElevatedButton({
    super.key,
    required this.action,
    required this.title,
    this.width, this.icon,
  });

  final VoidCallback action;
  final String title;
  final double? width;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(Dimensions.buttonRadius),
      ),
      child: SizedBox(
        height: Dimensions.buttonHeight,
        width: width ?? double.infinity,
        child: ElevatedButton.icon(
          icon: icon,
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.buttonRadius),
            ),
          ),
          onPressed: action,
          label: Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
