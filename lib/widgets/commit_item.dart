import 'package:dominos_test/model/commit.dart';
import 'package:flutter/material.dart';

class CommitItem extends StatelessWidget {
  final Commit commit;

  CommitItem(this.commit);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //User row
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                width: 30,
                height: 30,
                child: commit.authorAvatarUrl.length > 0
                    ? Image.network(commit.authorAvatarUrl)
                    : Icon(Icons.person),
              ),
              SizedBox(width: 10),
              Text(
                commit.authorName,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          // Repo name and rating
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '# ',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Flexible(
                  child: Text(
                    commit.sha.substring(commit.sha.length - 5),
                    style: Theme.of(context).textTheme.bodyText2,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          //Repo description
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              commit.message,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black87.withOpacity(0.6),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
