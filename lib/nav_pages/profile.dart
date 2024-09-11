import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '/model/app_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final _key = GlobalKey<FormState>();
  late TextEditingController _emailController;
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  late DatabaseReference dataRef;

  initState() {
    super.initState();
    _emailController = TextEditingController(text: user!.email);
    dataRef = FirebaseDatabase.instance.ref();
    _viewUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                    child: Column(
            children: [
              //const Text('Your Info'),
              SizedBox(height: 55),
              Form(
                  key: _key,
                  child: Container(
                    width: 380,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _fullNameController,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your full name'
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: _emailController,
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: _phoneNumberController,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your phone number'
                              : null,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: _addressController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        SizedBox(
                          height: 250,
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent[100]),
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  // Update profile
                                  _updateProfile();
                                }
                              },
                              child: Text(
                                'Update Profile',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 20),
                              )),
                        )
                      ],
                    ),
                  ))
            ],
                    ),
                  ),
          )),
    );
  }

  void _updateProfile() {
    final appUser = AppUser(
        uid: user!.uid,
        email: user!.email!,
        fullName: _fullNameController.value.text,
        phoneNumber: _phoneNumberController.value.text,
        address: _addressController.value.text);
    dataRef.child('users').child(user!.uid).set(appUser.toJson()).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Profile updated successfully'),
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update profile  ${error.toString()}'),
      ));
    });
  }

  void _viewUserProfile() {
    dataRef
        .child('users')
        .child(user!.uid)
        .onValue
        .listen((DatabaseEvent event) {
      Map<String, dynamic> data =
          Map.from(event.snapshot.value as Map<Object?, Object?>);
      final appUser = AppUser.fromJson(data);
      setState(() {
        _phoneNumberController.text = appUser.phoneNumber;
        _fullNameController.text = appUser.fullName;
        _addressController.text = appUser.address ?? '';
      });
      // print(data);
      // print(data.runtimeType);
    });
  }
}
