import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // close the drawer
    if (identifier == 'filters') {
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitFilters; // 如果第一個是null，則用第二個fallback
      });
    }
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExist = _favoriteMeals.contains(meal);
    setState(() {
      if (isExist) {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favorite.');
      } else {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals
        .where((meal) =>
            (meal.isGlutenFree || !_selectedFilters[Filter.glutenFree]!) &&
            (meal.isLactoseFree || !_selectedFilters[Filter.lactoseFree]!) &&
            (meal.isVegetarian || !_selectedFilters[Filter.vegetarian]!) &&
            (meal.isVegan || !_selectedFilters[Filter.vegan]!))
        .toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        onToggleFavorite: _toggleMealFavoriteStatus,
        meals: _favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
