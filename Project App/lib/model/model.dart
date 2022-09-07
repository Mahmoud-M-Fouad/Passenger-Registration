import 'dart:typed_data';
import 'dart:ui';

class Passenger{
  late final int id ;
  late final String name;
  late final String phone;
  late final String address;
  late final String age;
  late final String job ;
  late final String country;
  late final String money;
  late final String notes;
  late final String picture;
  late final String date;
  Passenger(
  {
   required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.age,
    required this.job,
    required this.country,
    required this.money,
    required this.notes,
    required this.picture,
    required this.date,
  });

  Map<String ,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'phone':phone,
      'address':address,
      'age':age,
      'job':job,
      'country':country,
      'money':money,
      'notes':notes,
      'picture':picture,
      'date':date,
    };
  }

  @override
  String toString() {
    return 'Course {id : $id ,name : $name , phone : $phone, address : $address ,'
        ' age : $age , job : $job , country : $country, money : $money , picture : $picture '
        ', notes : $notes, date : $date}';
  }


}