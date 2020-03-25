import 'package:dominos_test/model/commit.dart';

class Repository {
  String name;
  String fullName;
  String description;
  int rating;

  String authorName;
  String authorAvatarUrl;
  List<Commit> lastCommits;

  Repository({
    this.name,
    this.fullName,
    this.rating,
    this.authorAvatarUrl,
    this.authorName,
    this.lastCommits,
    this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      fullName: json['full_name'],
      description: json['description'] ?? "",
      rating: json['stargazers_count'],
      authorName: json['owner']['login'],
      authorAvatarUrl: json['owner']['avatar_url'],
    );
  }
}
