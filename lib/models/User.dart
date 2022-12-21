class UserModel {
  const UserModel(this.uid, this.email, this.name, this.profilePic);
  final String uid;
  final String email;
  final String name;
  final String profilePic;

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(map["uid"], map['email'], map['name'], map['profilePic']);
  }
  Map<String, dynamic> toJson() {
    return {"uid": uid, "name": name, "email": email, "profilePic": profilePic};
  }
}
