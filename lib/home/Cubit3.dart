import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'States3.dart';
import '../model/meal.dart';

class FireCubit extends Cubit<States> {
  FireCubit(super.Loading);
  final user = FirebaseAuth.instance.currentUser;

  void fetchCart() {

    if (dataRef.child("users").child(user!.uid).get() != Null) {
      dataRef.child("cart").child(user!.uid).get().then((snapshot) {
        if (snapshot.value != null) {
          List<Object?> l = List.of(snapshot.value as List<Object?>);
          List<Meal> m1 = [];
          l.forEach((e) {
            dataRef
                .child("meals")
                .child(e.toString().split('-')[0])
                .child(e.toString().split('-')[1])
                .get()
                .then((snapshot) {
              Map<String, dynamic> data =
              Map.from(snapshot.value as Map<Object?, Object?>);
              print(data);
              Meal h = Meal.fromJson(data);
              print(h);
              m1.add(h);
              print(m1.length);
            });
          });
          emit(Success(m1));
        } else if(!snapshot.exists)
          emit(Failture("No Orders"));
        else
          emit(Loading());
      });
    } else
      emit(Failture('No Orders, profile info uncompleted'));
  }
}
