import 'meal.dart';

class AppUser {
  String uid = '';
  String email = '';
  String fullName = '';
  String phoneNumber = '';
  String address='';
  List favorites=[];

  AppUser(
      {required this.uid,
      required this.email,
      required this.fullName,
      required this.phoneNumber,
     required this.address});

  AppUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }
 void updateFav(Meal meal,bool selected){
    if(selected)
    this.favorites.add(meal);
    else
      this.favorites.remove(meal);
 }
  Map<String,dynamic>toJson() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
