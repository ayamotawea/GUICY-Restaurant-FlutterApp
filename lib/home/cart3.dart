import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'States3.dart';
import '../model/meal.dart';
import 'Cubit3.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final user = FirebaseAuth.instance.currentUser;
  //List<Meal> meal;
/* void initState() {

    super.initState();
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Another click to fetch Orders")));

    });
  }*/
  List<Meal> meal = [];
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 1000,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<FireCubit, States>(
                  builder: (BuildContext context, snapshot) {
                if (snapshot is Success) {
                  meal = snapshot.meals;
                  return SafeArea(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, int index) => ListTile(
                        title: Text(
                          meal[index].title,
                          style: TextStyle(fontSize: 16),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(snapshot.meals[index].img),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              meal[index].time,
                              style: TextStyle(color: Colors.blueAccent[100]),
                            ),
                            SizedBox(
                              width: 90,
                            ),
                            Text(
                              meal[index].price,
                              style: TextStyle(fontSize: 19),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                meal.removeAt(index);
                                dataRef
                                    .child("cart")
                                    .child(user!.uid)
                                    .get()
                                    .then((snapshot) {
                                  List<Object?> data =
                                      List.of(snapshot.value as List<Object?>);
                                  data.removeAt(index);
                                  print("rrrrremoved");
                                  dataRef
                                      .child("cart")
                                      .child(user!.uid)
                                      .set(data);
                                  context.read<FireCubit>().fetchCart();
                                  print("context");
                                });
                              });
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            )),
                      ),
                      itemCount: snapshot.meals.length,
                      scrollDirection: Axis.vertical,
                    ),
                  );
                } else if (snapshot is Failture) {
                  return Center(child: Text(snapshot.message));
                } else
                  return CircularProgressIndicator();
              }),
              (show)
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        "Click to fetch orders",
                        style: TextStyle(color: Colors.blueAccent[200]),
                      ))
                  : SizedBox(
                      height: 0,
                      width: 0,
                    )
            ],
          ),
        ),
      ),
    ));
  }
}
