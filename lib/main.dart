import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filter_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }

        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toogleFavorite(String mealId){
    final _existingIndex = _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (_existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(_existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool isMealFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meal App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(225, 224, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(_favoriteMeals),
          CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routeName: (context) => MealDetailScreen(_toogleFavorite, isMealFavorite),
          FilterScreen.routeName: (context) => FilterScreen(_setFilters, _filters),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
          // if (settings.name == '/meal-detail') {
          //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
          // } else if (settings.name == '/something-else') {
          //   return MaterialPageRoute(builder: (context) => CategoriesScreen());
          // }
          // return MaterialPageRoute(builder: (context) => CategoryMealsScreen());
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
              builder: (context) => CategoriesScreen(),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal App'),
      ),
      body: CategoriesScreen(),
    );
  }
}
