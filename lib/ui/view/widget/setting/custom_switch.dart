import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.onChanged,
    required this.value,
  });
  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: SizedBox(
        height: 25,
        width: 50,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              height: 25,
              width: 50,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                color: value
                    ? t.colorScheme.primary
                    : t.colorScheme.secondaryContainer,
              ),
            ),
            AnimatedAlign(
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? t.colorScheme.primaryContainer : Colors.white,
                  boxShadow: [
                    if (value)
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.15),
                        spreadRadius: 0.5,
                        blurRadius: 1,
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
