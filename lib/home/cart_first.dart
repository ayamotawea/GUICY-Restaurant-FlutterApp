import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'States3.dart';
import 'cart3.dart';
import 'Cubit3.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: BlocProvider(child: MyCart(), create: (context)=>FireCubit(Loading())..fetchCart()));

  }
}
