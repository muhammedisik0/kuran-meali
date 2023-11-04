import 'package:flutter/material.dart';

class SettingsItemButton extends StatelessWidget {
  const SettingsItemButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.child,
  }) : super(key: key);

  final Function() onPressed;
  final Icon icon;
  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 60,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 20),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
