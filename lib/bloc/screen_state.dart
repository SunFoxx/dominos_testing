import 'package:dominos_test/model/repository.dart';

abstract class ScreenState {
  bool isLoading;
  List<Repository> repositories;

  ScreenState({this.isLoading, this.repositories});
}

class InitialState extends ScreenState {
  InitialState() : super(isLoading: false, repositories: []);
}

class LoadingState extends ScreenState {
  LoadingState() : super(isLoading: true, repositories: []);
}

class LoadedState extends ScreenState {
  LoadedState(List<Repository> repositories)
      : super(isLoading: false, repositories: repositories);
}

class ErrorState extends ScreenState {
  String message;

  ErrorState(this.message, {List<Repository> repositories = const []})
      : super(isLoading: false, repositories: repositories);
}
