import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

const kInitFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(kInitFilters);

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals
      .where((meal) =>
          (meal.isGlutenFree || !activeFilters[Filter.glutenFree]!) &&
          (meal.isLactoseFree || !activeFilters[Filter.lactoseFree]!) &&
          (meal.isVegetarian || !activeFilters[Filter.vegetarian]!) &&
          (meal.isVegan || !activeFilters[Filter.vegan]!))
      .toList();
});
