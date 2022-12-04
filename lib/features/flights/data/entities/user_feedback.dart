class UserFeedback {
  final String uid;
  final String fid;
  final int rating;
  final String comment;

  const UserFeedback({
    required this.uid,
    required this.fid,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fid': fid,
      'rating': rating,
      'comment': comment,
    };
  }
}
