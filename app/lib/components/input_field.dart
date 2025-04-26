import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  const InputField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.actionIcon,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ),
        suffixIcon: actionIcon != null
            ? ElevatedButton.icon(
                icon: Icon(actionIcon),
                onPressed: onAction,
                label: const Text("Search"),
              )
            : null,
      ),
    );
  }
}
