import 'package:flutter/material.dart';

class SwitchItem extends StatelessWidget {
  const SwitchItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSet,
    required this.onToggle,
  });
  final String title;
  final String subtitle;
  final bool isSet;
  final void Function(bool isChecked) onToggle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isSet,
      onChanged: onToggle,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
