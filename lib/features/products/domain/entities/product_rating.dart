import 'package:json_annotation/json_annotation.dart';

part 'product_rating.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductRating {
  final double rate;
  final int count;

  ProductRating({required this.rate, required this.count});

  factory ProductRating.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingFromJson(json);
  Map<String, dynamic> toJson() => _$ProductRatingToJson(this);
}
