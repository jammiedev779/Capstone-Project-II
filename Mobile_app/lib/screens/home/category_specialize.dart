// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoriesScreen(),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(
        name: 'Dentistry',
        iconUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLKM1BpG07uEmR0mBszQbFIAOPS2uuP5QqNCzduXaH12eQegIhIUIZ-0t0Tw4JNBrs2zc&usqp=CAU'),
    Category(
        name: 'Cardiology',
        iconUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLKM1BpG07uEmR0mBszQbFIAOPS2uuP5QqNCzduXaH12eQegIhIUIZ-0t0Tw4JNBrs2zc&usqp=CAU'),
    Category(
        name: 'Lung',
        iconUrl: 'https://example.com/icons/pulmonology.png'),
    Category(
        name: 'General',
        iconUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLKM1BpG07uEmR0mBszQbFIAOPS2uuP5QqNCzduXaH12eQegIhIUIZ-0t0Tw4JNBrs2zc&usqp=CAU'),
    Category(
        name: 'Neurology',
        iconUrl:
            'hhttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLKM1BpG07uEmR0mBszQbFIAOPS2uuP5QqNCzduXaH12eQegIhIUIZ-0t0Tw4JNBrs2zc&usqp=CAU'),
    Category(
        name: 'Stomuch',
        iconUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLKM1BpG07uEmR0mBszQbFIAOPS2uuP5QqNCzduXaH12eQegIhIUIZ-0t0Tw4JNBrs2zc&usqp=CAU'),
    Category(
        name: 'Laboratory',
        iconUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLKM1BpG07uEmR0mBszQbFIAOPS2uuP5QqNCzduXaH12eQegIhIUIZ-0t0Tw4JNBrs2zc&usqp=CAU'),
    Category(
        name: 'Vaccination',
        iconUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLKM1BpG07uEmR0mBszQbFIAOPS2uuP5QqNCzduXaH12eQegIhIUIZ-0t0Tw4JNBrs2zc&usqp=CAU'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement "See All" functionality
            },
            child: Text('See All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
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
      ),
    );
  }
}

class Category {
  final String name;
  final String iconUrl;

  Category({required this.name, required this.iconUrl});
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
            child: Image.network(
              category.iconUrl,
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
