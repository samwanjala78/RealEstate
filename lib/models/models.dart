import 'package:flutter/material.dart';
import 'package:real_estate/gen/assets.gen.dart';

class Message {
  String sender, messageId, senderId, text, timestamp;
  bool seen;

  Message({
    required this.sender,
    required this.messageId,
    required this.seen,
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  static Message fromJson({
    required String messageId,
    required Map<String, dynamic> json,
  }) => Message(
    messageId: messageId,
    sender: json["sender"],
    seen: json["seen"],
    senderId: json["senderId"],
    text: json["text"],
    timestamp: json["timestamp"],
  );
}

class Chat {
  String chatId, chattingWith, lastMessage, lastTimestamp;
  String? profilePicUrl;

  Chat({
    required this.chatId,
    required this.lastMessage,
    required this.chattingWith,
    required this.profilePicUrl,
    required this.lastTimestamp,
  });

  static Chat fromJson({
    required String chatId,
    required Map<String, dynamic> json,
  }) => Chat(
    chatId: chatId,
    lastMessage: json["lastMessage"],
    chattingWith: json["chattingWith"],
    lastTimestamp: json["lastTimestamp"],
    profilePicUrl: json["profilePicUrl"],
  );
}

class Property {
  List<String> imageUrls;
  bool liked;
  String id;
  int views;
  double lat, lng, rating;
  String title,
      location,
      price,
      bedrooms,
      bathrooms,
      area,
      type,
      description,
      contactName,
      contactNumber,
      contactEmail;
  List<String> features;

  Property({
    this.id = "",
    required this.contactEmail,
    required this.contactNumber,
    required this.contactName,
    required this.features,
    required this.imageUrls,
    required this.liked,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.type,
    required this.views,
    required this.lat,
    required this.lng,
    this.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  });

  Map<String, dynamic> toJson() => {
    "contactEmail": contactEmail,
    "contactNumber": contactNumber,
    "contactName": contactName,
    "features": features,
    "imageUrls": imageUrls,
    "liked": liked,
    "title": title,
    "location": location,
    "lat": lat,
    "lng": lng,
    "price": price,
    "rating": rating,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "area": area,
    "type": type,
    "views": views,
    "description": description,
  };

  static Property fromJson(Map<String, dynamic> json) => Property(
    id: json["_id"] ?? "",
    contactEmail: json["contactEmail"],
    contactNumber: json["contactNumber"],
    contactName: json["contactName"],
    features: List<String>.from(json["features"]),
    imageUrls: List<String>.from(json["imageUrls"]),
    liked: json["liked"],
    title: json["title"],
    location: json["location"],
    lat: json["lat"],
    lng: json["lng"],
    price: json["price"],
    rating: json["rating"],
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    area: json["area"],
    type: json["type"],
    views: json["views"],
    description: json["description"],
  );

  Property copyWith({
    List<String>? imageUrls,
    bool? liked,
    int? views,
    String? id,
    title,
    location,
    price,
    rating,
    bedrooms,
    bathrooms,
    area,
    type,
    description,
    contactName,
    contactNumber,
    contactEmail,
    double? lng,
    lat,
    List<String>? features,
  }) => Property(
    lng: lng ?? this.lng,
    lat: lat ?? this.lat,
    imageUrls: imageUrls ?? this.imageUrls,
    liked: liked ?? this.liked,
    id: id ?? this.id,
    title: title ?? this.title,
    location: location ?? this.location,
    price: price ?? this.price,
    rating: rating ?? this.rating,
    bedrooms: bedrooms ?? this.bedrooms,
    bathrooms: bathrooms ?? this.bathrooms,
    area: area ?? this.area,
    type: type ?? this.type,
    views: views ?? this.views,
    description: description ?? this.description,
    contactName: contactName ?? this.contactName,
    contactNumber: contactNumber ?? this.contactNumber,
    contactEmail: contactEmail ?? this.contactEmail,
    features: features ?? this.features,
  );
}

class Feature {
  final String label;
  final dynamic icon;

  const Feature(this.label, this.icon);

  static final gym = Feature("Gym", Assets.icons.dumbbellSolidFull);
  static final wifi = Feature("Wi-Fi", Icons.wifi);
  static final pool = Feature("Pool", Icons.pool);
  static final generator = Feature("Generator", Icons.battery_full);
  static final cityView = Feature("City view", Icons.location_city);
  static final greenery = Feature("Greenery", Icons.park);
  static final ampleParking = Feature(
    "Ample parking",
    Assets.icons.squareParkingSolidFull,
  );
  static final gatedCommunity = Feature("Gated community", Icons.security);
  static final spacious = Feature("Spacious", Icons.crop_square);

  static final values = {
    "gym": gym,
    "wifi": wifi,
    "pool": pool,
    "generator": generator,
    "cityView": cityView,
    "greenery": greenery,
    "ampleParking": ampleParking,
    "gatedCommunity": gatedCommunity,
    "spacious": spacious,
  };
}

class LocalUser {
  String firstName, lastName, email, phoneNumber, password, id;
  String? profilePicUrl;
  double? reviews;
  int? saved, listed, views;
  List<String>? likedProperties;

  LocalUser({
    this.views,
    this.reviews,
    this.saved,
    this.listed,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.profilePicUrl,
    this.likedProperties,
    this.id = "",
  });

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password,
    "profilePicUrl": profilePicUrl,
    "likedProperties": likedProperties,
  };

  static LocalUser fromJson(Map<String, dynamic> json) => LocalUser(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    profilePicUrl: json["profilePicUrl"],
    likedProperties: List<String>.from(json["likedProperties"]),
  );

  LocalUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? profilePicUrl,
    List<String>? likedProperties,
  }) => LocalUser(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    password: password ?? this.password,
    profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    likedProperties: likedProperties ?? this.likedProperties,
  );
}

enum SortOptions {
  priceLow("Price low"),
  priceHigh("Price high"),
  rating("Rating");
  // newest("Newest first");

  final String option;

  const SortOptions(this.option);
}

enum PropertyType {
  forRent("For Rent"),
  forSale("For Sale");

  final String type;

  const PropertyType(this.type);
}

class ChattingWith{
  String chattingWith;
  String? profilePicUrl;

  ChattingWith({
    required this.chattingWith,
    required this.profilePicUrl
  });
}