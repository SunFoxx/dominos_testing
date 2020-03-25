import 'package:dominos_test/bloc/screen_bloc.dart';
import 'package:dominos_test/bloc/screen_events.dart';
import 'package:dominos_test/model/repository.dart';
import 'package:dominos_test/widgets/commit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryItem extends StatefulWidget {
  final Repository repository;

  RepositoryItem({Key key, this.repository}) : super(key: key);

  @override
  _RepositoryItemState createState() => _RepositoryItemState();
}

class _RepositoryItemState extends State<RepositoryItem>
    with SingleTickerProviderStateMixin {
  bool expanded = false;

  Widget _buildCommits(BuildContext context) {
    Widget content;
    if (expanded == true) {
      if (widget.repository.lastCommits == null) {
        content = Container(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        );
      } else {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.repository.lastCommits
              .map((item) => CommitItem(item))
              .toList(),
        );
      }
    } else {
      content = SizedBox();
    }

    return AnimatedSize(
      curve: Curves.easeInOutCirc,
      duration: Duration(milliseconds: 750),
      vsync: this,
      child: content,
    );
  }

  void onExpandPress() {
    if (!expanded && widget.repository.lastCommits == null) {
      // ignore: close_sinks
      ScreenBloc bloc = BlocProvider.of<ScreenBloc>(context);
      bloc.add(SearchCommits(widget.repository));
    }
    this.setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.5),
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 2.0),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //User row
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                width: 40,
                height: 40,
                child: Image.network(widget.repository.authorAvatarUrl),
              ),
              SizedBox(width: 20),
              Text(
                widget.repository.authorName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          // Repo name and rating
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  widget.repository.name,
                  style: Theme.of(context).textTheme.headline5,
                  softWrap: true,
                ),
                fit: FlexFit.tight,
              ),
              SizedBox(width: 20),
              Icon(Icons.star, color: Colors.amberAccent),
              Text(
                widget.repository.rating.toString(),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          //Repo description
          widget.repository.description.length > 0
              ? Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.repository.description,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black87.withOpacity(0.6),
                        ),
                  ),
                )
              : SizedBox(),
          GestureDetector(
            onTap: this.onExpandPress,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              color: Colors.transparent,
              child: Text(
                expanded ? 'Hide' : 'Show last commits',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ),
          this._buildCommits(context),
        ],
      ),
    );
  }
}
