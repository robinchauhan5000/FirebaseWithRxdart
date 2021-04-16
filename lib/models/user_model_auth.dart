class UserModelAuth {
  final String userId;
  final String email;

  UserModelAuth({this.email, this.userId});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'email': email};
  }

  UserModelAuth.fromJson(Map<String, dynamic> firestore)
      : userId = firestore['userId'],
        email = firestore['email'];
}
