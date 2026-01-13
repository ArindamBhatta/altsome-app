import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.avatarImage,
    this.appConfig,
    this.kycDocs,
    this.birthDay,
    this.country,
    required this.email,
    required this.name,
    required this.userName,
    required this.userId,
    this.dialCode,
    this.phone,
    this.subscribedTopics,
    this.cryptoWalletCoins,
    this.bio,
  });

  final String? avatarImage;
  final AppConfig? appConfig;
  final KYCDocs? kycDocs;
  final String? birthDay;
  final String? country;
  final String email;
  final String name;
  final String userName;
  final String userId;
  final String? dialCode;
  final String? phone;
  final String? bio;
  final List? subscribedTopics;
  final int? cryptoWalletCoins;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      avatarImage: json["avatarImage"] ?? '',
      appConfig: json["appConfig"] == null
          ? null
          : AppConfig.fromJson(json["appConfig"]),
      birthDay: json["birthDay"] ?? '',
      country: json["country"] ?? '',
      email: json["email"] ?? '',
      name: json["name"] ?? '',
      userName: json["userName"] ?? '',
      userId: json["userId"] ?? '',
      dialCode: json["dialCode"] ?? '',
      phone: json["phone"] ?? '',
      bio: json["bio"] ?? '',
      subscribedTopics: json["subscribedTopics"],
      cryptoWalletCoins: json['cryptoWalletCoins'] ?? 0);

  Map<String, dynamic> toJson() => {
        "avatarImage": avatarImage ?? '',
        "appConfig": appConfig?.toJson(),
        "birthDay": birthDay,
        "country": country,
        "email": email,
        "name": name,
        "userName": userName,
        "userId": userId,
        "dialCode": dialCode,
        "phone": phone,
        "bio": bio,
        "subscribedTopics": subscribedTopics,
        "cryptoWalletCoins": cryptoWalletCoins
      };
}

class KYCDocs {
  KYCDocs(
      {this.selfieImagePath,
      this.photoIdImagePath,
      this.documentType,
      this.issuedCountry});
  final String? selfieImagePath;
  final String? photoIdImagePath;
  final String? issuedCountry;
  final String? documentType;

  factory KYCDocs.fromJson(Map<String, dynamic> json) => KYCDocs(
        selfieImagePath: json["selfieImagePath"] ?? '',
        photoIdImagePath: json["photoIdImagePath"] ?? '',
        issuedCountry: json['issuedCountry'] ?? '',
        documentType: json['documentType'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "selfieImagePath": selfieImagePath ?? '',
        "photoIdImagePath": photoIdImagePath ?? '',
        "issuedCountry": photoIdImagePath ?? '',
        "documentType": photoIdImagePath ?? '',
      };
}

class AppConfig {
  AppConfig({
    this.isSelfieUploaded,
    this.isPhotoIdUploded,
    this.isKycSubmitted,
    this.isKycVerified,
    this.isMobileVerified,
    this.isEmailVerified,
    this.isTwoStepLoginEnabled,
  });

  final bool? isSelfieUploaded;
  final bool? isPhotoIdUploded;
  final bool? isKycSubmitted;
  final bool? isKycVerified;
  final bool? isMobileVerified;
  final bool? isEmailVerified;
  final bool? isTwoStepLoginEnabled;

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        isSelfieUploaded: json["isSelfieUploaded"] ?? false,
        isPhotoIdUploded: json["isPhotoIdUploded"] ?? false,
        isKycSubmitted: json["isKYCSubmitted"] ?? false,
        isKycVerified: json["isKycVerified"] ?? false,
        isMobileVerified: json["isMobileVerified"] ?? false,
        isEmailVerified: json["isEmailVerified"] ?? false,
        isTwoStepLoginEnabled: json["isTwoStepLoginEnabled"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "isSelfieUploaded": isSelfieUploaded ?? false,
        "isPhotoIdUploded": isPhotoIdUploded ?? false,
        "isKYCSubmitted": isKycSubmitted ?? false,
        "isKycVerified": isKycVerified ?? false,
        "isMobileVerified": isMobileVerified ?? false,
        "isEmailVerified": isEmailVerified ?? false,
        "isTwoStepLoginEnabled": isTwoStepLoginEnabled ?? false,
      };
}
