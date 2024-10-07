import 'package:flutter/material.dart';
import 'package:food_app/pages/home/main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [

  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainFoodPage(),
    );
  }
}
