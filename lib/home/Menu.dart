import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/login2.dart';
import '../model/meal.dart';
import 'item_1.dart';

class MenuState extends StatefulWidget {
  const MenuState({super.key});

  @override
  State<MenuState> createState() => _MenuStateState();
}

class _MenuStateState extends State<MenuState> {
  List<Meal> meal = [
  ];
  DatabaseReference dataRef = FirebaseDatabase.instance.ref();
  final m = {
    0: "breakfast",
    1: "lunch",
    2: "fastfood",
    3: "dissert",
    4: "drinks"
  };
  int selectedIndex = 0;
  final items = [
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Text(
          "Breakfast",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        label: '-----------------------------'),
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Text(
          "Launch",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        label: '--------------------'),
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Text(
          "Fast Food",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        label: '---------------------------'),
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Text(
          "Dissert",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        label: '---------------------'),
    BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Text(
          "Drinks",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        label: '--------------------'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFC3DCF6),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              height: 688,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Colors.white,
                      width: 600,
                      child: Container(
                        height: 72,
                        width: 600,
                        decoration: BoxDecoration(
                            color: Color(0xFFC3DCF6),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: BottomNavigationBar(
                          elevation: 0,
                          selectedFontSize: 5,
                          selectedLabelStyle: TextStyle(color: Colors.black54),
                          //  selectedIconTheme: IconThemeData(weight: 2),
                          backgroundColor: Colors.transparent,
                          selectedItemColor: Colors.black,
                          unselectedItemColor: Colors.black54,
                          items: items.map((e) => e).toList(),
                          currentIndex: selectedIndex,
                          onTap: (value) {
                            setState(() {
                              selectedIndex = value;

                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(future: Meals(selectedIndex),
                    builder: (context, state) {
                      if (state.hasData && state.data !=[]) {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height: 688,
                              child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: state.data!.length,
                                  itemBuilder: (context, int index) =>
                                      GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MyItem(
                                                      meal: state.data![index],
                                                      type: m[selectedIndex]!,index: index+1))),
                                          //or inkwell used to add onTap for thing has'nt as card
                                          child: Card(
                                              semanticContainer: true,
                                              elevation: 5,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(13)),
                                              margin: EdgeInsets.only(
                                                  right: 16,
                                                  left: 16,
                                                  top: 7,
                                                  bottom: 7),
                                              color: Colors.white,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 130,
                                                    width: double.infinity,
                                                    child: Image.network(
                                                      state.data![index].img,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Text(
                                                    "   ${state.data![index].subtitle}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .watch_later_outlined,
                                                        size: 14,
                                                        color: Colors
                                                            .blueAccent[100],
                                                      ),
                                                      Text(
                                                        " ${state.data![index].time}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueAccent[100],
                                                            fontSize: 11),
                                                      ),
                                                      SizedBox(width: 43),
                                                      Icon(
                                                        Icons
                                                            .star_border_outlined,
                                                        size: 14,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        " ${state.data![index].rate}",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 11),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    "    ${state.data![index].price}",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )))),
                            ),
                          ),
                        );
                      } else if (state.hasError)
                        return Text(state.error.toString());
                      else
                        return CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ]),
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

 Future<List<Meal>> Meals(int selectedIndex) async {
    int n = 12;
    meal=[];
    DataSnapshot d= await dataRef
        .child("meals")
        .child(m[selectedIndex]!).get();
    n=d.children.length;
    for (int i = 1; i <= n; i++) {
      final snapshot =
          await dataRef.child('meals/${m[selectedIndex]}/$i').get();
      if (snapshot.exists) {
        print(snapshot.value);
      } else {
        print('No data available.');
      }
      Map<String, dynamic> data =
          Map.from(snapshot.value as Map<Object?, Object?>);
      Meal h = Meal.fromJson(data);
      meal.add(h);
      print(h.subtitle);
    }
    return meal;
  }
}
