import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(
        name: 'Dentistry', icon: 'assets/icons/categories/dentistry_icon.jpg'),
    Category(
        name: 'Cardiology',
        icon: 'assets/icons/categories/cardiology_icon.jpg'),
    Category(
        name: 'Pulmonology',
        icon: 'assets/icons/categories/pulmonology_icon.jpg'),
    Category(name: 'General', icon: 'assets/icons/categories/general_icon.jpg'),
    Category(
        name: 'Neurology', icon: 'assets/icons/categories/neurology_icon.jpg'),
    Category(
        name: 'Gastroenteritis',
        icon: 'assets/icons/categories/gastroenteritis_icon.jpg'),
    Category(
        name: 'Laboratory',
        icon: 'assets/icons/categories/laboratory_icon.jpg'),
    Category(
        name: 'Vaccination',
        icon: 'assets/icons/categories/vaccination_icon.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // Implement "See All" functionality
                  },
                  child: Text('See All',
                      style: TextStyle(color: Color(0xff6B7280))),
                ),
              ]),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryTile(category: category);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final String icon;

  Category({required this.name, required this.icon});
}

class CategoryTile extends StatelessWidget {
  final Category category;

  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              category.icon,
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, size: 40),
            ),
          ),
          // SizedBox(height: 8.0),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
