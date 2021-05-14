import 'package:object_mapper/annotations.dart';
import 'package:object_mapper/object_mapper.dart';
part 'main.g.dart';

final json = {
  "id": 1,
  "name": "Fantasy",
  "books": [
    {"id": 1, "name": "The Hobbit", "author": "J. R. R. Tolkien", "publish_at": "1937-09-21"},
    {"id": 2, "name": "Harry Potter", "author": "J. K. Rowling", "publish_at": "1997-12-01"}
  ]
};


class CategoryInfo with Mappable {
  // Attributes
  int? id;
  String? name;
  List<BookInfo>? books;

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("name", name, (v) => name = v);
    map<BookInfo>("books", books, (v) => books = v);
  }
}

@mappable
class BookInfo with _Mappable {
  // Attributes
  int? id;
  String? name;
  String? author;

  @modify(key: "publish_at", transform: DateTransform())
  DateTime? publishAt;
}


void main() async {
  // Register factory
  Mappable.factories = {CategoryInfo: () => CategoryInfo(), BookInfo: () => BookInfo()};

  // Convert json to CategoryInfo
  final category = Mapper.fromJson(json).toObject<CategoryInfo>();
  print(category!.toJson());
}
