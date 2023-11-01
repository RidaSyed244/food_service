import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String customerName;
  final String customerReview;
  final String customerDP;
  final String rating;

  UserModel({
    required this.customerName,
    required this.customerReview,
    required this.customerDP,
    required this.rating,
  });

  UserModel copyWith({
    String? customerName,
    String? customerReview,
    String? customerDP,
    String? rating,
  }) {
    return UserModel(
      customerName: customerName ?? this.customerName,
      customerReview: customerReview ?? this.customerReview,
      customerDP: customerDP ?? this.customerDP,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerName': customerName,
      'customerReview': customerReview,
      'customerDP': customerDP,
      'rating': rating,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      customerName: map['customerName'] as String,
      customerReview: map['customerReview'] as String,
      customerDP: map['customerDP'] as String,
      rating: map['rating'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(customerName: $customerName, customerReview: $customerReview, customerDP: $customerDP, rating: $rating)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.customerName == customerName &&
        other.customerReview == customerReview &&
        other.customerDP == customerDP &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return customerName.hashCode ^
        customerReview.hashCode ^
        customerDP.hashCode ^
        rating.hashCode;
  }
}

final List<UserModel> ratings = [
  UserModel(
      customerName: "Rida",
      customerReview:
          "Great food I like this place, I think best place of\nColarodo. Chilling with friends",
      customerDP: "",
      rating: "4.5"),
  UserModel(
      customerName: "Ayesha",
      customerReview:
          "One of the best and good food corner.\nSpecially the Burger,Lemonade.",
      customerDP: "",
      rating: "5.0"),
  UserModel(
      customerName: "Sana",
      customerReview:
          "Great food I like this place, I think best place of\nColarodo. Chilling with Friends :)",
      customerDP: "",
      rating: "4.2"),
  UserModel(
      customerName: "Romaisa",
      customerReview: "I love this food very much.",
      customerDP: "",
      rating: "4.0")
];

class AllRestraunts {
  final String? restraunt_logo;
  final String? restaurant_name;
  final String? restaurant_address;
  final String? status;
  final String? restraunt_currency;
  final String? deliver_charges;
  final String? deliver_time;
  final String? CategoryName;
  final String? OrderType;
  final String? uid;
  final double? averagePrice;
  final String? categoryType;
  final double? latitude;
  final double? longitude;
  final String? token;

  AllRestraunts({
    this.restraunt_logo,
    this.restaurant_name,
    this.restaurant_address,
    this.status,
    this.restraunt_currency,
    this.deliver_charges,
    this.deliver_time,
    this.categoryType,
    this.CategoryName,
    this.OrderType,
    this.uid,
    this.averagePrice,
    this.latitude,
    this.longitude,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restraunt_logo': restraunt_logo,
      'restaurant_name': restaurant_name,
      'restaurant_address': restaurant_address,
      'status': status,
      'restraunt_currency': restraunt_currency,
      'deliver_charges': deliver_charges,
      'deliver_time': deliver_time,
      'CategoryName': CategoryName,
      'OrderType': OrderType,
      'uid': uid,
      'averagePrice': averagePrice,
      'categoryType': categoryType,
      'latitude': latitude,
      'longitude': longitude,
      'token': token,
    };
  }

  factory AllRestraunts.fromMap(Map<String, dynamic> map) {
    return AllRestraunts(
      restraunt_logo: map['restraunt_logo'] != null ? map['restraunt_logo'] as String : null,
      restaurant_name: map['restaurant_name'] != null ? map['restaurant_name'] as String : null,
      restaurant_address: map['restaurant_address'] != null ? map['restaurant_address'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      restraunt_currency: map['restraunt_currency'] != null ? map['restraunt_currency'] as String : null,
      deliver_charges: map['deliver_charges'] != null ? map['deliver_charges'] as String : null,
      deliver_time: map['deliver_time'] != null ? map['deliver_time'] as String : null,
      CategoryName: map['CategoryName'] != null ? map['CategoryName'] as String : null,
      OrderType: map['OrderType'] != null ? map['OrderType'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      averagePrice: map['averagePrice'] != null ? map['averagePrice'] as double : null,
      categoryType: map['categoryType'] != null ? map['categoryType'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllRestraunts.fromJson(String source) => AllRestraunts.fromMap(json.decode(source) as Map<String, dynamic>);
}

/////////////All Orders//////////////////////
class AllOrders {
  final String ProductDescription;
  final String ProductName;
  final int ProductPrice;
  final int ProductQuantity;

  AllOrders({
    required this.ProductDescription,
    required this.ProductName,
    required this.ProductPrice,
    required this.ProductQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ProductDescription': ProductDescription,
      'ProductName': ProductName,
      'ProductPrice': ProductPrice,
      'ProductQuantity': ProductQuantity,
    };
  }

  factory AllOrders.fromMap(Map<String, dynamic> map) {
    return AllOrders(
      ProductDescription: map['ProductDescription'] as String,
      ProductName: map['ProductName'] as String,
      ProductPrice: map['ProductPrice'] as int,
      ProductQuantity: map['ProductQuantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllOrders.fromJson(String source) =>
      AllOrders.fromMap(json.decode(source) as Map<String, dynamic>);
}

//////////////Current Users////////////
 
