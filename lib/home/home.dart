import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fmans7/home/favorites.dart';

import '/auth/login2.dart';

import '../nav_pages/profile.dart';
import 'Menu.dart';
import 'cart_first.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = const [
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Icon(Icons.menu),
        label: 'menu'),
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Icon(Icons.favorite_border),
        label: 'favorites'),
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Icon(Icons.shopping_cart_outlined),
        label: 'cart'),
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Icon(Icons.person_2_outlined),
        label: 'Profile'),
  ];
  int _selectedIndex = 0;
Map n={0:"Menu",1:"Favourites",2:"My Orders",3:"Profile"};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Text(""),
        title:  Text(n[_selectedIndex],style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: _bottomNavigationScreens(_selectedIndex),
      bottomNavigationBar: Container(
        height: 70,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(40)),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.blueAccent[100],
          items: items.map((e) => e).toList(),
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }

  _logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      },
    );
  }

  _bottomNavigationScreens(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return MenuState();
      case 1:
        return MyFav();
      case 2:
        return MyCartPage();
      default:
        return ProfileScreen();
    }
  }
}
