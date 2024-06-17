// import 'dart:convert';
//
// class Contact {
//   int id;
//   int studentId;
//   String name;
//   DateTime updatedAt;
//
//   Certificate({required this.id,
//     required this.name,
//     required this.studentId,
//     required this.updatedAt});
//
//   Certificate.empty()
//       : id = 0,
//         studentId = 0,
//         updatedAt = DateTime.now(),
//         name = '';
//
//   factory Certificate.fromJson(Map<String, dynamic> json) {
//     return Certificate(
//       id: json['id'],
//       studentId: json['studentId'],
//       name: json['name'],
//       updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
//     );
//   }
//
//   Certificate copyWith({
//     int? id,
//     int? studentId,
//     String? name,
//     String? position,
//     String? description,
//     DateTime? updatedAt
//   }) {
//     return Certificate(
//       id: id ?? this.id,
//       studentId: studentId ??  this.studentId,
//       name: name ?? this.name,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return{
//       'id':  this.id,
//       'studentId': this.studentId,
//       'name': this.name,
//       'updatedAt': this.updatedAt.toIso8601String()
//     };
//   }
// }