class Food{

  String name;
  double price;
  double calories;
  Food({required this.name, required this.calories,required this.price});
  @override
  String toString() {
    // TODO: implement toString
    return "Name: ${this.name} \nPrice: ${this.price} \nCalories: ${this.calories}";
  }
}