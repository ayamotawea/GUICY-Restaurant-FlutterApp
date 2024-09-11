import '../model/meal.dart';

abstract class States{}
class Success extends States{
  List<Meal>meals;
  Success(this.meals);
}
class Failture extends States{
  String message;
  Failture(this.message);
}
class Loading extends States{}