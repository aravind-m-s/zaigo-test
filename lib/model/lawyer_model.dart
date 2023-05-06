class LawyerModel {
  LawyerModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.address,
    required this.state,
    required this.fieldOfExpertise,
    required this.bio,
    required this.level,
    required this.hoursLogged,
    required this.phoneNo,
    required this.email,
    required this.profilePicture,
    required this.rating,
    required this.ranking,
  });

  int id;
  String uuid;
  String name;
  String address;
  String state;
  String fieldOfExpertise;
  String bio;
  String level;
  String hoursLogged;
  String phoneNo;
  String email;
  String profilePicture;
  String rating;
  String ranking;

  factory LawyerModel.fromJson(Map<String, dynamic> json) => LawyerModel(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        address: json["address"],
        state: json["state"],
        fieldOfExpertise: json["field_of_expertise"],
        bio: json["bio"],
        level: json["level"],
        hoursLogged: json["hours_logged"],
        phoneNo: json["phone_no"],
        email: json["email"],
        profilePicture: json["profile_picture"],
        rating: json["rating"],
        ranking: json["ranking"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "address": address,
        "state": state,
        "field_of_expertise": fieldOfExpertise,
        "bio": bio,
        "level": level,
        "hours_logged": hoursLogged,
        "phone_no": phoneNo,
        "email": email,
        "profile_picture": profilePicture,
        "rating": rating,
        "ranking": ranking,
      };
}
