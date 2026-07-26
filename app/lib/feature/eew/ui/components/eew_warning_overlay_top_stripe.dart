import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:flutter/material.dart';

const eewWarningOverlayStripeHeight = 10.0;

class EewWarningOverlayTopStripe extends StatelessWidget {
  const EewWarningOverlayTopStripe({super.key});

  @override
  Widget build(BuildContext context) => WarningStripeDecoration(
    colors: const [Colors.red, Colors.black],
    height: MediaQuery.paddingOf(context).top + eewWarningOverlayStripeHeight,
  );
}
