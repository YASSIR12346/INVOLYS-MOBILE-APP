
class LoginInputModel{
  String Username;
  String? Login;
  String? Password;
  String HashedPassword;
  String DomainId;
  bool RememberLogin;
  String ReturnUrl;
  bool ResetPassword;

  LoginInputModel({
    this.Username="username",
    required this.Login,
    required this.Password,
    this.HashedPassword="hashedPassword",
    this.DomainId="DomainId",
    this.RememberLogin=false,
    this.ReturnUrl="returnUrl",
    this.ResetPassword=false
});

 Map<String, dynamic> toJson() => {
        "Username": this.Username,
        "Login": this.Login,
        "Password": this.Password,
        "HashedPassword": this.HashedPassword,
        "DomainId": this.DomainId,
        "RememberLogin": this.RememberLogin,
        "ReturnUrl": this.ReturnUrl,
        "ResetPassword": this.ResetPassword,
    };

}