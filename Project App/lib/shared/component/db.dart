import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/model.dart';

  late final Future<Database> database;
  Future<void> createDatabase() async
  {
      database = openDatabase(
      join(await getDatabasesPath() ,
          'passenger_db04.db'),
      onCreate: (db , version)
      {
        return db.execute("CREATE TABLE passenger (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , name TEXT NOT NULL ,phone TEXT NOT NULL,address TEXT NOT NULL,age TEXT NOT NULL,job TEXT NOT NULL"
            ",country TEXT NOT NULL,money TEXT NOT NULL ,notes TEXT NOT NULL ,picture TEXT NOT NULL ,date TEXT NOT NULL ) "
        ).then((value){
          print("Database Created");
          var person = Passenger(id: 0,name: "d",address: "d",age: "s",country: "d", job: "d",money: "sd", date: 'wefx', phone: ';rfg', notes: 'zewf', picture: 'dde');
          Init_insertCousre(person);
        });

      },
      version: 1,
    );

  }

  Future<void> insertPassenger(Passenger c ,  BuildContext context)async{
    final Database db = await database;
    await db.insert('passenger', c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace
    ).then((value) {showToastAdd(context);}
    ).catchError((e){
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(

        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text(' فشل إضافة مسافر جديد بنجاح' , style: TextStyle(color: Colors.red,fontSize: 18),textAlign: TextAlign.right,),
        ),
      );
    });
  }

Future<void> Init_insertCousre(Passenger c)async{
  final Database db = await database;
  await db.insert('passenger', c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Passenger>> passenger() async {
    final Database db =await database;
    final List<Map<String , dynamic>> map = await db.query('passenger' ,
    );
    return List.generate(map.length,
            (index)
        {
          return Passenger(
            id: map[index]['id'],
            name: map[index]['name'],
            phone: map[index]['phone'],
            address: map[index]['address'],
            age: map[index]['age'],
            country: map[index]['country'],
            job: map[index]['job'],
            money: map[index]['money'],
            notes: map[index]['notes'],
            picture: map[index]['picture'],
            date: map[index]['date'],
          );
        }
    );
  }



Future<bool> Check_course_day(String day ) async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('passenger' ,
      where: "day = ? " , whereArgs: [day]
  );
  return map.isNotEmpty ?true : false;
}

Future<List<Passenger>> passengerId(int id ) async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('passenger' ,
      where: "id = ? " , whereArgs: [id]
  );
  return List.generate(map.length,
          (index)
      {
        return Passenger(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          address: map[index]['address'],
          age: map[index]['age'],
          country: map[index]['country'],
          job: map[index]['job'],
          money: map[index]['money'],
          notes: map[index]['notes'],
          picture: map[index]['picture'],
          date: map[index]['date'],
        );
      }
  );
}

Future<List<Passenger>> allPassenger() async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('passenger' ,
      where: "id != ? " , whereArgs: [0]
  );
  return List.generate(map.length,
          (index)
      {
        return Passenger(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          address: map[index]['address'],
          age: map[index]['age'],
          country: map[index]['country'],
          job: map[index]['job'],
          money: map[index]['money'],
          notes: map[index]['notes'],
          picture: map[index]['picture'],
          date: map[index]['date'],
        );
      }
  );
}

Future<List<Passenger>> allPassengerSearch(String name) async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await
   db.rawQuery("SELECT * FROM passenger WHERE name LIKE '%$name%'"
  );
  return List.generate(map.length,
          (index)
      {
        return Passenger(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          address: map[index]['address'],
          age: map[index]['age'],
          country: map[index]['country'],
          job: map[index]['job'],
          money: map[index]['money'],
          notes: map[index]['notes'],
          picture: map[index]['picture'],
          date: map[index]['date'],
        );
      }
  );
}

Future<List<Map<String, Object?>>> allPassengerName() async {
  final Database db =await database;
   var map = await db.rawQuery('SELECT name FROM passenger WHERE id !=?', [0]);

  return map;
}

Future<int> maxPassengerID() async {
var id;
  final Database db =await database;
 // final List<Map<String, dynamic>> map
id = Sqflite.firstIntValue(await db.rawQuery('SELECT max(id) FROM passenger'));

  return id;
}

Future<bool> checkAllPassenger(int id) async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('passenger' ,
      where: "id = ? " , whereArgs: [id]
  );
  return map.isNotEmpty ?true : false;
}

Future<bool> allPassengerYesOrNo() async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('passenger' ,
      where: "id !=0 " ,
  );
  return map.isNotEmpty ?true : false;
}


Future<void> updatePassenger(Passenger c , BuildContext context)async
{
    final db = await database ;
    await db.update('passenger', c.toMap() , where: "id = ? " , whereArgs: [c.id]
    ).then((value) {showToastUpdate(context);}
    ).catchError((e){
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(

        const SnackBar(

          content: Text('فشل تعديل بيانات هذا المسافر' , style: TextStyle(color: Colors.red,fontSize: 18),textAlign: TextAlign.right,),
        ),
      );
    });
  }

Future<void> updateImage(
{
  required String photo ,required int id ,required BuildContext context
})async
{
  final db = await database ;
  await db.rawUpdate('UPDATE passenger SET picture = ? WHERE id = ?', [photo, id]).
  then((value) {showToastUpdateImage(context);}
  ).catchError((e){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(

      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('فشل تعديل صورة هذا المسافر' , style: TextStyle(color: Colors.red,fontSize: 18),textAlign: TextAlign.right,),
      ),
    );
  });
}

void showToastUpdate(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(

    const SnackBar(
      duration: Duration(seconds: 1),
      content: Text('تم تعديل بيانات المسافر بنجاح' , style: TextStyle(color: Colors.green,fontSize: 18 ),textAlign: TextAlign.right,),
    ),
  );
}
void showToastAdd(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(

    const SnackBar(
      duration: Duration(seconds: 1),
      content: Text('تم إضافة مسافر جديد بنجاح ' , style: TextStyle(color: Colors.green,fontSize: 18),textAlign: TextAlign.right,),
    ),
  );
}
void showToastDelete(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(

    const SnackBar(
      duration: Duration(seconds: 1),
      content: Text('تم حذف المسافر بنجاح' , style: TextStyle(color: Colors.green,fontSize: 18),textAlign: TextAlign.right,),
    ),
  );
}
void showToastUpdateImage(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(

    const SnackBar(
      duration: Duration(seconds: 1),
      content: Text('تم تعديل صورة المسافر بنجاح' , style: TextStyle(color: Colors.green,fontSize: 18 ),textAlign: TextAlign.right,),
    ),
  );
}

  Future<void> deletePassenger(int id ,BuildContext context)async
  {
    final db = await database ;
    await db.delete('passenger', where: "id = ? " , whereArgs: [id]
    ).then((value) {showToastDelete( context);}).catchError((error)
    {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('فشل حذف هذا المسافر' , style: TextStyle(color: Colors.red,fontSize: 18),textAlign: TextAlign.right,),
        ),
      );
    });
  }





// use it

/*
// 1.
var math = Course(id: 1, name: 'alaa', teacher: 'father', day: 'sunday', hour: 1, phone: '01012');
await insertCousre(math);


// 2.
var math2 = Course(id: 1, name: 'alaa', teacher: 'father', day: 'sunday', hour: 1, phone: '01012');
await UpdateCourse(math);
// 3.
await DeleteCourse(math.id);

// 4.
print(await course());


*/