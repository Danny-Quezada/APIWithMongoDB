import 'dart:convert';
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';

import 'AppCore/IServices/IServices.dart';
import 'AppCore/Services/FoodServices.dart';
import 'Domain/entities/food.dart';
import 'Infraestructure/Repository/Food/FoodMongoRepository.dart';

IServices<Food> services = FoodServices(Pmodel: new FoodMongoRepository());
void main(List<String> arguments) async {
  var server = await HttpServer.bind("127.0.0.1", 3100);

  server.listen((HttpRequest request) async {
    if (request.uri.toString() == "/") {
      _get(request);
    } else if (request.uri.toString().startsWith("/posts") && request.uri.toString().contains("token")) {
      _post(request);
    } else if (request.uri.toString().startsWith('/?name')) {
      _find(request);
    }
  });
}

void _find(HttpRequest request) async {
  var uri = Uri.parse(request.uri.toString());
  Food food = await services.find(uri.queryParameters["name"]!);
  Map<String, dynamic>? foodMap = {
    "name": food.name,
    "calories": food.calories,
    "price": food.price
  };
  var enconded = jsonEncode(foodMap);
  request.response.headers.contentType =
      ContentType('application', 'json', charset: 'utf-8');
  request.response.write(enconded);
  request.response.close();
}

void _get(HttpRequest request) async {
  var encoded = jsonEncode(await services.Read());
  request.response.headers.contentType =
      ContentType('application', 'json', charset: 'utf-8');
  request.response.write(encoded);

  request.response.close();
}

void _post(HttpRequest request)async {
  Db db=await Db("mongodb://localhost:27017/Food");
 await db.open();
 
   var uri = Uri.parse(request.uri.toString());
 var token=await db.collection("token").findOne({"token":uri.queryParameters["token"]});
 if(token!=null){
   print(token);
 }
  Food food = Food(
      name: uri.queryParameters["name"]!,
      calories: double.tryParse(uri.queryParameters["calories"]!)!,
      price: double.tryParse(uri.queryParameters["price"]!)!);

  services.create(food);
  request.response.headers.contentType =
      ContentType('application', 'json', charset: 'utf-8');
  request.response.write('Exitoso');
  request.response.close();
}
