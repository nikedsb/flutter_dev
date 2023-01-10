import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

// class Geocode {
//   double lat;
//   double lng;
//   Geocode({required this.lat, required this.lng});
//   Map<String, String> toMap() => {"lat": lat.toString(), "lng": toString()};
// }

// class Address {
//   String street;
//   String suite;
//   String city;
//   String zipcode;
//   Map geo;
//   Address(
//       {required this.street,
//       required this.suite,
//       required this.city,
//       required this.zipcode,
//       required this.geo});

//   Map<String, Object> toMap() => {
//         "street": street,
//         "suite": suite,
//         "city": city,
//         "zipcode": zipcode,
//         "geo": geo,
//       };
// }

// class Company {
//   String name;
//   String catchPhrase;
//   String bs;

//   Company({
//     required this.name,
//     required this.catchPhrase,
//     required this.bs,
//   });
//   Map<String, String> toMap() => {
//         'name': name,
//         'catchPhrase': catchPhrase,
//         'bs': bs,
//       };
// }

// @freezed
// class User with _$User {
//   const factory User({
//     required int id,
//     required String name,
//     required String username,
//     required String email,
//     required Map<String, Object> address,
//     required String phone,
//     required String website,
//     required Map<String, Object> company,
//   }) = _User;

//   factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
// }

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required String username,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
