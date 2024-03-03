import 'package:sqflite/sqflite.dart';

late final Map user;
late final Database database;

void createDatabase()async {
  database = await openDatabase(
      'users.db',
      version: 1,
      onCreate: (database, version) {
        print('Database is created successfully..');
        database.execute('CREATE TABLE users (id INTEGER PRIMARY KEY, email TEXT, password TEXT,)')
        .then((value){
          print('Table is created successfully..');
        }).catchError((error){
          print('Error occurred while creating users table: $error');
        });
      },
      onOpen: (database){
        print('Database is opened successfully..');
      }
  );
}

Future insertToDatabase({
  required String email,
  required String password
}){
  return database.transaction((txn){
    txn.rawInsert('INSERT INTO users (email, password) VALUES ("$email", "$password")')
        .then((value){
      print('$value is inserted successfully...');
    }).catchError((error){
      print('Error occurred while inserting into database: $error');
    });
    return Future(() => null);
  });
}

Future<bool> isDuplicated(String email)async{
  bool error = false;
  List users = await database.rawQuery('SELECT * FROM users WHERE email = $email')
      .catchError((error) {
    print('Error occurred while getting duplicated email: $error');
    error = true;
  });
  if(!error){
    return users.isNotEmpty;
  }
}

void getUser(String email, String password)async{
  bool error = false;
  List users = await database.rawQuery('SELECT * FROM users WHERE email = $email AND password = $password')
  .catchError((error){
    print('Error occurred while getting user: $error');
    error = true;
  });
  if(!error){
    user = users[0];
  }
}