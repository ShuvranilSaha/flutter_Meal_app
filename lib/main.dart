import 'package:flutter/material.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        home: MyHomePage(),
        routes: {
          CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
          MealDetailScreen.routeName: (context) => MealDetailScreen(),
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
