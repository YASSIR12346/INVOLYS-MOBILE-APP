
class User {
    String id;
    String username;
    String name;
    String surname;
    String email;
    String login;
    String domainId;
    Domain domain;

    User({
        required this.id,
        required this.username,
        required this.name,
        required this.surname,
        required this.email,
        required this.login,
        required this.domainId,
        required this.domain,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        login: json["login"],
        domainId: json["domainId"],
        domain: Domain.fromJson(json["domain"]),
    );

}


class Domain {
    String id;
    String name;
    String companyId;
    Company company;

    Domain({
        required this.id,
        required this.name,
        required this.companyId,
        required this.company,
    });

    factory Domain.fromJson(Map<String, dynamic> json) => Domain(
        id: json["id"],
        name: json["name"],
        companyId: json["companyId"],
        company: Company.fromJson(json["company"]),
    );
}





class Company {
    String id;
    String name;
    bool companyDefault;

    Company({
        required this.id,
        required this.name,
        required this.companyDefault,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        companyDefault: json["default"],
    );
}