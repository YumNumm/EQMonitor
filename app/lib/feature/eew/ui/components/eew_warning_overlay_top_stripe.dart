import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:material_ui/material_ui.dart';

const eewWarningOverlayStripeHeight = 10.0;

class const EewWarningOverlayTopStripe({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => WarningStripeDecoration(
    colors: const [Colors.red, Colors.black],
    height: MediaQuery.paddingOf(context).top + eewWarningOverlayStripeHeight,
  );
}
