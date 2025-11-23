/// Domain entity representing a registered user
///
/// This is a pure business object independent of data sources or UI
class UserEntity {
  final String token;
  final String username;

  const UserEntity({
    required this.token,
    required this.username,
  });

  /// Creates a copy with updated fields
  UserEntity copyWith({
    String? token,
    String? username,
  }) {
    return UserEntity(
      token: token ?? this.token,
      username: username ?? this.username,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          username == other.username;

  @override
  int get hashCode => token.hashCode ^ username.hashCode;

  @override
  String toString() => 'UserEntity(token: $token, username: $username)';
}