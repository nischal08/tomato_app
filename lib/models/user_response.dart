import 'dart:convert';

class UserResponse {
  final bool success;
  final String message;
  final Data data;
  UserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  UserResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return UserResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      success: map['success'],
      message: map['message'],
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) => UserResponse.fromMap(json.decode(source));

  @override
  String toString() => 'RegisterResponse(success: $success, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserResponse &&
      other.success == success &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}

class Data {
  final bool active;
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String role;
  final String password;
  final String verificationCode;
  final String expiresAt;
  final String createdAt;
  final int v;
  Data({
    required this.active,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.role,
    required this.password,
    required this.verificationCode,
    required this.expiresAt,
    required this.createdAt,
    required this.v,
  });

  Data copyWith({
    bool? active,
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? role,
    String? password,
    String? verificationCode,
    String? expiresAt,
    String? createdAt,
    int? v,
  }) {
    return Data(
      active: active ?? this.active,
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      role: role ?? this.role,
      password: password ?? this.password,
      verificationCode: verificationCode ?? this.verificationCode,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      '_id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'role': role,
      'password': password,
      'verificationCode': verificationCode,
      'expiresAt': expiresAt,
      'createdAt': createdAt,
      '__v': v,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      active: map['active'],
      id: map['_id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      email: map['email'],
      role: map['role'],
      password: map['password'],
      verificationCode: map['verificationCode'],
      expiresAt: map['expiresAt'],
      createdAt: map['createdAt'],
      v: map['__v']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(active: $active, _id: $id, firstname: $firstname, lastname: $lastname, email: $email, role: $role, password: $password, verificationCode: $verificationCode, expiresAt: $expiresAt, createdAt: $createdAt, __v: $v)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Data &&
      other.active == active &&
      other.id == id &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.email == email &&
      other.role == role &&
      other.password == password &&
      other.verificationCode == verificationCode &&
      other.expiresAt == expiresAt &&
      other.createdAt == createdAt &&
      other.v == v;
  }

  @override
  int get hashCode {
    return active.hashCode ^
      id.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      role.hashCode ^
      password.hashCode ^
      verificationCode.hashCode ^
      expiresAt.hashCode ^
      createdAt.hashCode ^
      v.hashCode;
  }
}