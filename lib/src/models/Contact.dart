

class Contact {

  static const String TABLE_NAME = "contacts";

  static const String ID_COLUMN = "id";
  static const String NAME_COLUMN = "name";
  static const String EMAIL_COLUMN = "email";
  static const String PHONE_COLUMN = "phone";
  static const String IMAGE_COLUMN = "image";

  int id;

  String name;
  String email;
  String phone;

  String image;

  Contact(this.id, this.name, this.email, this.phone, {this.image});

  Contact.fromMap(Map map){
    this.id    = map[ID_COLUMN];
    this.name  = map[NAME_COLUMN];
    this.email = map[EMAIL_COLUMN];
    this.phone = map[PHONE_COLUMN];
    this.image = map[IMAGE_COLUMN];
  }

  Map toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();

    if(id != null)
      map[ID_COLUMN] = this.id;

    map[NAME_COLUMN] = this.name;
    map[EMAIL_COLUMN] = this.email;
    map[PHONE_COLUMN] = this.phone;
    map[IMAGE_COLUMN] = this.image;

    return map;
  }

  @override
  String toString() {
    return "$id - $name - $phone - $email - $image";
  }


}