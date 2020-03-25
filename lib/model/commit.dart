class Commit {
  String message;
  String sha;

  String authorName;
  String authorAvatarUrl;

  Commit({
    this.message,
    this.sha,
    this.authorName,
    this.authorAvatarUrl,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      message: json['commit']['message'],
      sha: json['sha'],
      authorName: json['commit']['author']['name'],
      authorAvatarUrl:
          json['author'] != null ? json['author']['avatar_url'] : '',
    );
  }
}
