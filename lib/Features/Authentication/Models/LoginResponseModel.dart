import 'User.dart';

class LoginResponseModel {
    User user;
    String accessToken;
    dynamic encryptedAccessToken;
    dynamic refreshToken;
    int expireInSeconds;
    bool shouldResetPassword;
    dynamic passwordResetCode;
    String userId;
    bool requiresTwoFactorVerification;
    dynamic twoFactorAuthProviders;
    dynamic twoFactorRememberClientToken;
    dynamic returnUrl;
    DateTime refreshTokenExpireDate;

    LoginResponseModel({
        required this.user,
        required this.accessToken,
        required this.encryptedAccessToken,
        required this.refreshToken,
        required this.expireInSeconds,
        required this.shouldResetPassword,
        required this.passwordResetCode,
        required this.userId,
        required this.requiresTwoFactorVerification,
        required this.twoFactorAuthProviders,
        required this.twoFactorRememberClientToken,
        required this.returnUrl,
        required this.refreshTokenExpireDate,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        user: User.fromJson(json["user"]),
        accessToken: json["accessToken"],
        encryptedAccessToken: json["encryptedAccessToken"],
        refreshToken: json["refreshToken"],
        expireInSeconds: json["expireInSeconds"],
        shouldResetPassword: json["shouldResetPassword"],
        passwordResetCode: json["passwordResetCode"],
        userId: json["userId"],
        requiresTwoFactorVerification: json["requiresTwoFactorVerification"],
        twoFactorAuthProviders: json["twoFactorAuthProviders"],
        twoFactorRememberClientToken: json["twoFactorRememberClientToken"],
        returnUrl: json["returnUrl"],
        refreshTokenExpireDate: DateTime.parse(json["refreshTokenExpireDate"]),
    );

}