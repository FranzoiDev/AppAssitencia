abstract class CrudApi<T> {
  String apiUrl;

  CrudApi(this.apiUrl);

  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<T> create(T item);
  Future<T> update(int id, T item);
  Future<void> delete(int id);
}
