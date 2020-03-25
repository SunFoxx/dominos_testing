import 'package:dominos_test/bloc/screen_bloc.dart';
import 'package:dominos_test/bloc/screen_events.dart';
import 'package:dominos_test/bloc/screen_state.dart';
import 'package:dominos_test/widgets/repository_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    ScreenBloc bloc = BlocProvider.of<ScreenBloc>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Header with input
          Container(
            color: Colors.lightBlue[500],
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          isDense: true,
                          hintText: 'Input user name',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        onChanged: (text) => setState(() {
                          inputText = text;
                        }),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () => bloc.add(SearchByUser(inputText)),
                    iconSize: 30,
                    splashColor: Colors.amberAccent,
                    focusColor: Colors.amberAccent,
                  ),
                ],
              ),
            ),
          ),
          // Content
          Flexible(
            child: Stack(
              children: [
                //content
                BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is InitialState) {
                      return Center(child: Text('Input username to search'));
                    }
                    if (state is LoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is LoadedState || state is ErrorState) {
                      if (state.repositories.length > 0) {
                        return ListView(
                          children: state.repositories
                              .map<Widget>(
                                  (item) => RepositoryItem(repository: item))
                              .toList(),
                        );
                      }

                      return Center(
                        child: Text(
                            'No search results found, chage query and try again'),
                      );
                    }
                    return SizedBox();
                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      bool isError = state is ErrorState;

                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: double.infinity,
                        height: isError ? 50 : 0,
                        alignment: Alignment.center,
                        color: Colors.red[400],
                        child: isError
                            ? Text(
                                state.message,
                                style: TextStyle(color: Colors.white),
                              )
                            : SizedBox(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
