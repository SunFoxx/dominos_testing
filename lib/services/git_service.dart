import 'dart:convert';

import 'package:dominos_test/model/commit.dart';
import 'package:dominos_test/model/repository.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = 'https://api.github.com/';

Future<List<Repository>> searchReposByUsername(String username) async {
  http.Response response =
      await http.get('${BASE_URL}search/repositories?q=user:$username');

  if (response.statusCode == 200) {
    List rawRepos = json.decode(response.body)['items'];
    return rawRepos.map((item) => Repository.fromJson(item)).toList();
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}

Future<List<Commit>> searchCommitsByRepo(String repoName) async {
  http.Response response = await http.get('${BASE_URL}repos/$repoName/commits');
  dynamic resultJson = json.decode(response.body);

  if (response.statusCode == 200 && resultJson is List<dynamic>) {
    return resultJson
        .take(5)
        .toList()
        .map((item) => Commit.fromJson(item))
        .toList();
  } else {
    throw Exception('Error ${response.statusCode}, ${resultJson['message']}');
  }
}
