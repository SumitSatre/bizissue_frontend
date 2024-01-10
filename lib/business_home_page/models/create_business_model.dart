import 'package:json_annotation/json_annotation.dart';

part 'create_business_model.g.dart';

@JsonSerializable()
class CreateBusinessModel {
  String? name;
  String? industryType;
  String? city;
  String? country;

  CreateBusinessModel({
    this.name,
    this.industryType,
    this.city,
    this.country,
  });

  factory CreateBusinessModel.fromJson(Map<String, dynamic> json) =>
      _$CreateBusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBusinessModelToJson(this);

  CreateBusinessModel copyWith({
    String? name,
    String? industryType,
    String? city,
    String? country,
  }) {
    return CreateBusinessModel(
      name: name ?? this.name,
      industryType: industryType ?? this.industryType,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }
}
