
class UserResult {
  final String userId;
  final bool driver;

  UserResult({
   required this.userId,
   required this.driver,
});

  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
        userId: json['userId'] as String,
        driver: json['driver'] as bool,
    );
  }
}