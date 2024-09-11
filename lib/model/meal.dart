import 'package:firebase_database/firebase_database.dart';

DatabaseReference dataRef = FirebaseDatabase.instance.ref();
final m={0:"breakfast",1:"lunch",2:"fastfood",3:"dissert",4:"drinks"};
int selectedIndex = 0;
class Meal{
  String title="";
  String price="";
  String time="";
  String description="";
  String rate="";
  String img="";
  String? subtitle="";
  Meal(this.title,this.subtitle,this.img,this.price,this.time,this.rate,this.description);
  Meal.fromJson(Map<String, dynamic> json) {
    title = json['title'] ;
    price = json['price'] ;
    time = json['time'] ;
    description = json['description'] ;
    rate = json['rate'] ;
    img=json['img'] ;
    subtitle=json["subtitle"];
  }



}