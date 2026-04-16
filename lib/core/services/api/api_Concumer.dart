abstract class ApiConsumer {
  Future<dynamic> get(String path, {Object? data, Map<String, dynamic>? quary});

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? quary,
  });

  Future<dynamic> delet(
    String path, {
    Object? data,
    Map<String, dynamic>? quary,
  });

  Future<dynamic> put(String path, {Object? data, Map<String, dynamic>? quary});
}
