import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FiltersScreen(this.currentFilters, this.saveFilters, {super.key});
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool?) updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final Map<String, bool> seletedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(seletedFilters);
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile("Gluten-free",
                    "Only include gluten-free meals.", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue!;
                  });
                }),
                buildSwitchListTile(
                    "Lactose-free",
                    "Only include lactose-free meals.",
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue!;
                  });
                }),
                buildSwitchListTile(
                    "Vegetarian", "Only include vegetarian meals.", _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue!;
                  });
                }),
                buildSwitchListTile(
                    "Vegan", "Only include vegan meals.", _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue!;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
