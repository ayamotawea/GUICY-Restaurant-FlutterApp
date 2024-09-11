import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/meal.dart';

class MyFav extends StatefulWidget {
  MyFav({super.key});

  @override
  State<MyFav> createState() => _MyFavState();
}

class _MyFavState extends State<MyFav> {
  final user = FirebaseAuth.instance.currentUser;
  List<Meal> meal = [];
  String show = '';
  @override
  void initState() {
    super.initState();
    setState(() {
    SharedPreferences.getInstance().then((prefs) {
        List<String> r = prefs.getStringList("${user!.email}") ?? [];
        if (r != []) {
          r.forEach((e) {
            dataRef
                .child("meals")
                .child(e.split('-')[0])
                .child(e.split('-')[1])
                .get()
                .then((snapshot) {
              Map<String, dynamic> data =
                  Map.from(snapshot.value as Map<Object?, Object?>);
              Meal h = Meal.fromJson(data);
              meal.add(h);
              print(meal);
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (!meal.isEmpty)
            ? func() /*SafeArea(
                child: Container(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: meal.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                                onTap: () {
                                  return null;
                                },
                                //or inkwell used to add onTap for thing has'nt as card
                                child: Card(
                                    semanticContainer: true,
                                    elevation: 5,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    margin: EdgeInsets.only(
                                        right: 16, left: 16, top: 7, bottom: 7),
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
                                            meal[index].img,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Text(
                                          "   ${meal[index].subtitle}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.watch_later_outlined,
                                              size: 14,
                                              color: Colors.blueAccent[100],
                                            ),
                                            Text(
                                              " ${meal[index].time}",
                                              style: TextStyle(
                                                  color: Colors.blueAccent[100],
                                                  fontSize: 11),
                                            ),
                                            SizedBox(width: 43),
                                            Icon(
                                              Icons.star_border_outlined,
                                              size: 14,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              " ${meal[index].rate}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 11),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 110,
                                              child: Text(
                                                "    ${meal[index].price}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  SharedPreferences
                                                          .getInstance()
                                                      .then((prefs) {
                                                    List<String> r = prefs.getStringList("${user!.email}") ?? [];
                                                    r.removeAt(index);
                                                    meal.removeAt(index);
                                                    print(r);
                                                    prefs.setStringList("${user!.email}",r);
                                                    List<String> r1 = prefs.getStringList("${user!.uid}") ?? [];
                                                    r1.removeAt(index);
                                                    print(r1);
                                                    prefs.setStringList("${user!.uid}",r1);

                                                  });
                                                });
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.blueAccent[100],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ))))),
              )*/
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('$show'),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          show = "No Items";
                        });
                      },
                      child: (show == '')
                          ? Text(
                              'Click to show My Favorites',
                              style: TextStyle(color: Colors.blueAccent[200]),
                            )
                          : Text("No Items"))
                ],
              )));
  }
  Widget func(){
    return SafeArea(
      child: Container(
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: meal.length,
              itemBuilder: (BuildContext context, int index) =>
                  GestureDetector(
                      onTap: () {
                        return null;
                      },
                      //or inkwell used to add onTap for thing has'nt as card
                      child: Card(
                          semanticContainer: true,
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(13)),
                          margin: EdgeInsets.only(
                              right: 16, left: 16, top: 7, bottom: 7),
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
                                  meal[index].img,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "   ${meal[index].subtitle}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.watch_later_outlined,
                                    size: 14,
                                    color: Colors.blueAccent[100],
                                  ),
                                  Text(
                                    " ${meal[index].time}",
                                    style: TextStyle(
                                        color: Colors.blueAccent[100],
                                        fontSize: 11),
                                  ),
                                  SizedBox(width: 43),
                                  Icon(
                                    Icons.star_border_outlined,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    " ${meal[index].rate}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 11),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      "    ${meal[index].price}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        SharedPreferences
                                            .getInstance()
                                            .then((prefs) {
                                          List<String> r = prefs.getStringList("${user!.email}") ?? [];
                                          r.removeAt(index);
                                          meal.removeAt(index);
                                          print(r);
                                          prefs.setStringList("${user!.email}",r);
                                          List<String> r1 = prefs.getStringList("${user!.uid}") ?? [];
                                          r1.removeAt(index);
                                          print(r1);
                                          prefs.setStringList("${user!.uid}",r1);

                                        });
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.blueAccent[100],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))))),
    );
  }
}
