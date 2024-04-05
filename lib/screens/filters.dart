import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/switch_item.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    final setFilter = ref.read(filtersProvider.notifier).setFilter;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchItem(
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            isSet: activeFilters[Filter.glutenFree]!,
            onToggle: (isChecked) {
              setFilter(Filter.glutenFree, isChecked);
            },
          ),
          SwitchItem(
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            isSet: activeFilters[Filter.lactoseFree]!,
            onToggle: (isChecked) {
              setFilter(Filter.lactoseFree, isChecked);
            },
          ),
          SwitchItem(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            isSet: activeFilters[Filter.vegetarian]!,
            onToggle: (isChecked) {
              setFilter(Filter.vegetarian, isChecked);
            },
          ),
          SwitchItem(
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            isSet: activeFilters[Filter.vegan]!,
            onToggle: (isChecked) {
              setFilter(Filter.vegan, isChecked);
            },
          ),
        ],
      ),
    );
  }
}
