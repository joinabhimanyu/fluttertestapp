abstract class Model {
  /// It's really a shame that in 2022 you can't do something like this:
  // factory Model.fromJson<T extends Model>(Map<String, dynamic> json) {
  //   return T.fromJson(json);
  // }

  /// Or even declare an abstract factory that must be implemented:
  // factory Model.fromJson(Map<String, dynamic> json);

  // Not DRY, but this works.
  static T fromJson<T extends Model>(Map<String, dynamic> json) {
    switch (T) {
      case User:

        /// Why the heck without `as T`, does Dart complain:
        /// "A value of type 'User' can't be returned from the method 'fromJson' because it has a return type of 'T'."
        /// when clearly `User extends Model` and `T extends Model`?
        return User.fromJson(json) as T;
      case Todo:
        return Todo.fromJson(json) as T;
      case Post:
        return Post.fromJson(json) as T;
      default:
        throw UnimplementedError();
    }
  }

  Map<String, dynamic> toJson();
}

class User implements Model {
  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
  });

  final int id;
  final String username;
  final String name;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
      };
}

class Todo implements Model {
  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  final int id;
  final int userId;
  final String title;
  final bool completed;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        completed: json["completed"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "completed": completed,
      };
}

class Post implements Model {
  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  final int id;
  final int userId;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "body": body,
      };
}
