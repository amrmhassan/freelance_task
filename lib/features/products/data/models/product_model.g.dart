// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  price: (json['price'] as num).toDouble(),
  description: json['description'] as String,
  category: json['category'] as String,
  image: json['image'] as String,
  rating: ProductRating.fromJson(json['rating'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating.toJson(),
    };

ProductRating _$ProductRatingFromJson(Map<String, dynamic> json) =>
    ProductRating(
      rate: (json['rate'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ProductRatingToJson(ProductRating instance) =>
    <String, dynamic>{'rate': instance.rate, 'count': instance.count};
