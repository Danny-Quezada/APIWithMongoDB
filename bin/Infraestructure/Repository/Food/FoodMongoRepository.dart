import 'package:mongo_dart/mongo_dart.dart';

import '../../../Domain/entities/food.dart';
import '../../../Domain/interfaces/IModel.dart';

class FoodMongoRepository implements IModel<Food>{

  
  FoodMongoRepository(){
    
      
  }

  @override
  void create(t)async {
    Db db=await Db("mongodb://localhost:27017/Food");
    Map<String, dynamic> object={
      "name": t.name,
      "calories": t.calories,
      "price":t.price
    };
   await db.open();
    db.collection("Food collection").insert(object);
  }

  @override
  void delete(t) {
    // TODO: implement delete
  }

  @override
  Future<Food> find(String name)async {
     Db db=await Db("mongodb://localhost:27017/Food");
     
        await db.open();

    var foodMap=await db.collection("Food collection").findOne({'name':name});
    if(foodMap !=null){
       Food food= Food(name: foodMap['name'] , calories: foodMap['calories'] , price: foodMap['price'] );
       return food;
    }
   else{
     Food food=Food(name: "null", calories: 0, price: 0);
     return food;
   }

  }

  @override
  void update(t) {
    // TODO: implement update
  }

  @override
    Future<List<Map<String,dynamic>>> Read()  async{
         Db db=await Db("mongodb://localhost:27017/Food");
        await db.open();
        final foods= db.collection("Food collection").find().toList();
        return foods;
  }
  

}