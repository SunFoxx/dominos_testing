import 'package:dominos_test/bloc/screen_events.dart';
import 'package:dominos_test/bloc/screen_state.dart';
import 'package:dominos_test/model/commit.dart';
import 'package:dominos_test/model/repository.dart';
import 'package:dominos_test/services/git_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  @override
  ScreenState get initialState => InitialState();

  @override
  Stream<ScreenState> mapEventToState(ScreenEvent event) async* {
    try {
      if (event is SearchByUser) {
        yield LoadingState();
        List<Repository> repositories =
            await searchReposByUsername(event.query);
        yield LoadedState(repositories);
      }
      if (event is SearchCommits) {
        List<Commit> commits = await searchCommitsByRepo(event.repo.fullName);
        event.repo.lastCommits = commits;
        yield LoadedState(state.repositories);
      }
    } catch (e) {
      yield ErrorState(e.toString(), repositories: state.repositories);
    }
  }
}
