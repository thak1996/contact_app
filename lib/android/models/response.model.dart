import 'dart:convert';

class ResponseModel {
  ResponseModel({
    required this.data,
    this.statusCode,
  });

  dynamic data;
  int? statusCode;

  ResponseModel copyWith({
    dynamic data,
    int? statusCode,
  }) {
    return ResponseModel(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'statusCode': statusCode,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      data: map['data'] as dynamic,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseModel(data: $data, statusCode: $statusCode)';

  @override
  bool operator ==(covariant ResponseModel other) {
    if (identical(this, other)) return true;

    return other.data == data && other.statusCode == statusCode;
  }

  @override
  int get hashCode => data.hashCode ^ statusCode.hashCode;
}
