class UserData{

  static  String? Token;
  static String UserId="unknown";
  static String Surname="";
  static String Name="";

   static init(String token,String userId,String surname,String name){
    Token=token;
    UserId=userId;
    Surname=surname;
    Name=name;
   }

}