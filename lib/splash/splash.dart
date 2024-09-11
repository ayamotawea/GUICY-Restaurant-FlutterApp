import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/auth/login2.dart';
import '/home/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), (){
     if(FirebaseAuth.instance.currentUser != null){
       Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(),));
     } else {
       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));

     }
    });
    return const Scaffold(
      backgroundColor: Color(0xFFB2EBF2),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [CircleAvatar(
            radius: 130,
            backgroundImage:
            NetworkImage("https://www.lecremedelacrumb.com/wp-content/uploads/2017/05/one-pan-spanish-chicken-rice-106-500x375.jpg"),
          ),
            Text('Guicy',style: TextStyle(fontSize: 60,color: Colors.white,fontStyle: FontStyle.italic),),
          ],
        ),
      ),
    );
  }
}
