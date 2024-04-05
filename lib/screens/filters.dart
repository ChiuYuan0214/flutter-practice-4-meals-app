import 'package:flutter/material.dart';
import 'package:meals/widgets/switch_item.dart';
// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });
  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.pop(context);
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;

          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchItem(
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              isSet: _glutenFreeFilterSet,
              onToggle: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
            ),
            SwitchItem(
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              isSet: _lactoseFreeFilterSet,
              onToggle: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            SwitchItem(
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              isSet: _vegetarianFilterSet,
              onToggle: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
            ),
            SwitchItem(
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              isSet: _veganFilterSet,
              onToggle: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
