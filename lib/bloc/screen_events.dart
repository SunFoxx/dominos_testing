import 'package:dominos_test/model/repository.dart';

abstract class ScreenEvent {}

class SearchByUser extends ScreenEvent {
  String query;

  SearchByUser(this.query);
}

class SearchCommits extends ScreenEvent {
  Repository repo;

  SearchCommits(this.repo);
}
