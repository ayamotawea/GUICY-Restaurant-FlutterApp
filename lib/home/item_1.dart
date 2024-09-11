import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/app_user.dart';
import '../model/meal.dart';

class MyItem extends StatefulWidget {
  Meal meal;
  String type;
  int index;
  MyItem(
      {super.key, required this.meal, required this.type, required this.index});

  @override
  State<MyItem> createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  final user = FirebaseAuth.instance.currentUser;
  bool selected = false;
  List<String> favorite = [];
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        favorite = prefs.getStringList("${user!.uid}") ?? [];
        favorite.forEach((e) {
          if (e == widget.meal.title) selected = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 290,
                width: double.infinity,
                child: Image.network(
                  widget.meal.img,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Container(
                      width: 287,
                      child: Row(
                        children: [
                          Text(
                            "    ${widget.meal.title}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  //SizedBox(width: 40),
                  Icon(
                    Icons.watch_later_outlined,
                    size: 13,
                    color: Colors.blueAccent[100],
                  ),
                  Text(widget.meal.time,
                      style: TextStyle(
                          fontSize: 13, color: Colors.blueAccent[100])),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.star_border_outlined,
                    size: 13,
                    color: Colors.red,
                  ),
                  Text(widget.meal.rate,
                      style: TextStyle(fontSize: 13, color: Colors.red))
                ],
              ),
              Text("    ${widget.meal.price}",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      height: 390,
                      width: 360,
                      child: Text(widget.meal.description,
                          style: TextStyle(
                            fontSize: 16,
                          ))),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selected = !selected;
                          setFavoriteState(widget.meal.title, selected);
                          setFavoriteobj(widget.type, selected, widget.index);
                        });
                      },
                      child: Icon(
                        selected ? Icons.favorite : Icons.favorite_border,
                        color: Colors.teal,
                        size: 40,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    width: 280,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                         DataSnapshot g= await dataRef.child("users").child(user!.uid).get();
                        if (g.value !=
                            null) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          dataRef
                              .child("cart")
                              .child(user!.uid)
                              .get()
                              .then((snap) {
                            if (snap.value == null) {
                              List<String?> cart = [];
                              cart.add("${widget.type}-${widget.index}");
                              print(cart);
                              dataRef
                                  .child("cart")
                                  .child(user!.uid)
                                  .set(cart);
                            } else {
                              dataRef
                                  .child("cart")
                                  .child(user!.uid)
                                  .get()
                                  .then((snapshot) {
                                List<Object?> data =
                                    List.of(snapshot.value as List<Object?>);
                                data.add("${widget.type}-${widget.index}");
                                dataRef
                                    .child("cart")
                                    .child(user!.uid)
                                    .set(data);
                                print(data);
                              });
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${widget.meal.title} added to Cart"),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Cmplete your profile info first to be able to make order"),
                          ));
                        }
                      },
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        //shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.zero)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  setFavoriteobj(String type, bool selected, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> l;
    if (selected) {
      l = prefs.getStringList("${user!.email}") ?? [];

      l.add("$type-$index");
    } else {
      l = prefs.getStringList("${user!.email}") ?? [];

       l.remove("$type-$index");
    }
    prefs.setStringList('${user!.email}', l);
    print(prefs.getStringList("${user!.email}"));
  }

  setFavoriteState(String title, bool selected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> l;
    if (selected) {
      l = prefs.getStringList("${user!.uid}") ?? [];

      l.add(title);
    } else {
      l = prefs.getStringList("${user!.uid}") ?? [];
      l.remove(title);
    }
    prefs.setStringList('${user!.uid}', l);
  }
}
