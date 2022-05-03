 abstract class IModel<T>{
  void update(T t);
  void create(T t);
  Future<T> find(String name);
  void delete(T t);
  Future<List<Map<String,dynamic>>> Read();
 
}