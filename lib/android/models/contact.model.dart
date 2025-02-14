class Contact {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'status': status,
    };
  }

  Contact copyWith({
    int? id,
    String? name,
    String? email,
    String? gender,
    String? status,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'status': status,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      status: map['status'] as String,
    );
  }

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, email: $email, gender: $gender, status: $status)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        status.hashCode;
  }
}
