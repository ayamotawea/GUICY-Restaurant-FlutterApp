import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fmans7/model/app_user.dart';
import 'package:fmans7/model/meal.dart';
import '/home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool isSignupPressed = false;
  bool isSigninPressed = true;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _emailController1 = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _confirmPasswordController1 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailController1.dispose();
    _passwordController1.dispose();
    _confirmPasswordController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                    children: [
                      Container(
                        child: Column(
              children: [
                SizedBox(
                  height: 160,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isSigninPressed = !isSignupPressed;
                              isSignupPressed = false;
                            });
                          },
                          child: Text("Sign In",
                              style:
                                  TextStyle(fontSize: 23, color: Colors.black)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 2,
                          width: 58,
                          color:
                              isSigninPressed ? Colors.white : Colors.transparent,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 125,
                    ),
                    Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isSignupPressed = !isSigninPressed;
                                isSigninPressed = false;
                              });
                            },
                            child: Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 23, color: Colors.black))),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 2,
                          width: 58,
                          color:
                              isSignupPressed ? Colors.white : Colors.transparent,
                        )
                      ],
                    )
                  ],
                ),
              ],
                        ),
                        height: 220,
                        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.lightBlueAccent[100]),
                      ),
                      isSigninPressed
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome!",
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      Text(
                          'Enter Email and Password                                         '),
                      SizedBox(
                        height: 5,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(color: Colors.white24,
                                width: 340,
                                child: Theme(
                                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter email'
                                        : null,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 340,
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter password'
                                      : null,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      labelText: 'Password',
                                      prefixIcon: Icon(Icons.lock)),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Container(
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor:
                                          Colors.lightBlueAccent[100]),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _login(_emailController.value.text,
                                          _passwordController.value.text);
                                    }
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),SizedBox(height: 186,)
                            ],
                          ))
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 27,
                      ),
                      Text(
                        "Welcome Back!",
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),Text(
                          'Create your account                                                   '),
                      SizedBox(
                        height: 5,
                      ),
                      Form(
                          key: _formKey1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 340,
                                child: TextFormField(
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter email'
                                      : null,
                                  controller: _emailController1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 340,
                                child: TextFormField(
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter password'
                                      : null,
                                  controller: _passwordController1,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      labelText: 'Password',
                                      prefixIcon: Icon(Icons.lock)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 340,
                                child: TextFormField(
                                  validator: (value) => value!.isEmpty ||
                                          value != _passwordController1.value.text
                                      ? 'Please enter confirm password'
                                      : null,
                                  controller: _confirmPasswordController1,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      labelText: 'Confirm Password',
                                      prefixIcon: Icon(Icons.lock)),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor:
                                      Colors.lightBlueAccent[100]),
                                  onPressed: () {
                                    if (_formKey1.currentState!.validate()) {
                                      _register(_emailController1.value.text,
                                          _passwordController1.value.text);
                                    }
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),SizedBox(height: 150,)
                            ],
                          ))
                    ],
                  ),
                ),
                    Container(height: 200,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.lightBlueAccent[100]),)],
                  )),
        ));
  }

  Future<void> _login(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      print('${e.code} - ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
    }
  }

  Future<void> _register(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      print('${e.code} - ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
    }
  }
}
