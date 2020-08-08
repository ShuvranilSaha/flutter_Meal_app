import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  final Function _saveFilters;
  final Map<String, bool> _currentSelectedFilters;

  FilterScreen(this._saveFilters, this._currentSelectedFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isVegetarian = false;
  var _isVegan = false;
  var _isLactoseFree = false;


  @override
  void initState() {
    _isGlutenFree = widget._currentSelectedFilters['gluten'];
    _isVegetarian = widget._currentSelectedFilters['vegetarian'];
    _isVegan = widget._currentSelectedFilters['vegan'];
    _isLactoseFree = widget._currentSelectedFilters['lactose'];
    super.initState();
  }

  Widget _switchListTile(bool currentFilteredValues, String title,
      String subTitle, Function updatedValue) {
    return SwitchListTile(
      value: currentFilteredValues,
      onChanged: updatedValue,
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final _selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian
              };
              widget._saveFilters(_selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meals selections',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _switchListTile(_isGlutenFree, 'Gluten-Free',
                    'Only include gluten-free products', (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                }),
                _switchListTile(_isLactoseFree, 'Lactos-Free',
                    'Only include Lactos-free products', (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                }),
                _switchListTile(_isVegetarian, 'only Vegeterian',
                    'Only include vegetarian products', (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                }),
                _switchListTile(
                    _isVegan, 'Vegan', 'Only include Vegan products',
                    (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
