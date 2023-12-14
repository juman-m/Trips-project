class Chat {
  int? id;
  String? createdAt;
  String? message;
  String? fromUser;
  String? toUser;
  bool? isMine;

  Chat({this.id, this.createdAt, this.message, this.fromUser, this.toUser});

  Chat.fromJson(Map<String, dynamic> json, String currentUserId) {
    id = json['id'];
    createdAt = json['created_at'];
    message = json['message'];
    fromUser = json['from_user'];
    toUser = json['to_user'];
    isMine = json['from_user'] == currentUserId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['message'] = message;
    data['from_user'] = fromUser;
    data['to_user'] = toUser;
    return data;
  }
}
