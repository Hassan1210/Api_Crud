

class Contact{

  int? id;
  String? name;
  String? phone;


  Contact({this.id,this.name,this.phone});


  Map<String,dynamic> toMap()=>{
    "id" : id,
    "name": name,
    "phone" : phone
  };


  Contact.fromMap(Map<dynamic,dynamic> map){
    id = int.parse(map['id']);
    name = map['name'];
    phone = map['phone'];
  }


}