import 'package:flutter/material.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    MainFoodPage(),
    Container(child: Center(child: Text("1"),),),
    Container(child: Center(child: Text("2"),),),
    Container(child: Center(child: Text("3"),),)

  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTapNav,
          currentIndex: _selectedIndex,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: "history"
            ),BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "cart"
            ),BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: "me"
            ),
          ]),
    );
  }
}
