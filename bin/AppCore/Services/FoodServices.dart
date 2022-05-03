import '../../Domain/entities/food.dart';
import '../../Domain/interfaces/IModel.dart';
import '../IServices/IServices.dart';

class FoodServices implements IServices<Food>{

  IModel<Food> model;
  FoodServices({required IModel<Food> Pmodel}):
    this.model=Pmodel;
  

  @override
  void create(t) {
    model.create(t);
  }

  @override
  void delete(t) {
    // TODO: implement delete
  }

  @override
  Future<Food> find(String name)async {
    // TODO: implement find
    return model.find(name);
  }

  @override
  void update(t) {
    // TODO: implement update
  }

  @override
  Future<List<Map<String,dynamic>>> Read()async{
    return await model.Read();
  }

}