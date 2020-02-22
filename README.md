# 

A package written in Dart that makes it easy for you to convert your model objects to and from JSON.
It's inspired by [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)



## Implement
- **Step 1**: Extend your class with `Mappable` mixin
```dart
class TestInfo with Mappable {
    //
}

```



- **Step 2**: Override `Mappable.mapping` method & add your map functions. Check more [use cases](#map---use-cases) here
```dart
class TestInfo with Mappable {
	int id;
	
    @override
	void mapping(Mapper map) {
		map("id", id, (v) => id = v);
	}
}

```



## Usage

- **Object from Map**
```dart
final json = {
	"id" : 2
};

final info = Mapper.fromJson(json).toObject<TestInfo>();
print(info.id); // 2
```

- **Object to Map**
```dart
final info = TestInfo();
info.id = 2;
final json = info.toJson();
print(json); // { "id": 2 }
```



## Map - Use Cases

- `int`, `string`, `numeric`, `bool`
```dart
void mapping(Mapper map) {
	map("field", field, (v) => field = v);
}
```
- `List` of object or nested object
```dart
void mapping(Mapper map) {
	map<ObjectClass>("field", field, (v) => field = v);
}
```
- With transform, such as `DateTransform`, `EnumTransform`
```dart
DateTime time;
void mapping(Mapper map) {
	map("time", time, (v) => time = v, DateTransform());
}
```



## Custom transform

Implement your class with `Transformable`
```
class EnumTransform<Object extends Enumerable, JSON> with Transformable<Object, JSON> {
    
    // Convert Json to Object
	Object fromJson(value) {
		if (value == null || !(value is JSON)) return null;
		return RawRepresentable(Object, value);
	}

    // Convert Object to Json
	JSON toJson(Object value) {
		if (value == null) return null;
		return value.rawValue;
	}
}
```