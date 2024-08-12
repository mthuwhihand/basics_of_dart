import 'package:basics_of_dart/models/person.dart';
import 'package:basics_of_dart/models/singer.dart';

void main() {
  // testOOP();
  testFutureAndStream();
}

void testOOP(){
  var person = Person('A0123', 'Minh Thư', 21, 170, 64);
  // var person = Person('A0123', 'Minh Thư', 21, 170);
  print("${person.name}\n----------------");
  print(person);
  print("---------------");
  person.says("Hello mọi người");
  print('Size: ${person.getTShirtSize()}');

  print("---------------");
  var defaultPerson = Person.Default("000");
  print("${defaultPerson.name}\n----------------");
  print(defaultPerson);
  print("---------------");
  defaultPerson.says("Hello toi la Bob");
  // Đoạn này để test late với final
  // Ở Person khai báo:
  // late final String? _id;
  // print("---------------");
  // person.id = "B123";
  // print(person);
  // print("---------------");
  // person.id = "C123";
  // print(person);
  //Kết quả: Rejecting promise with error: LateInitializationError: Field '_id' has already been initialized.


  //Singer extends Person
  print("---------------");
  var singer = Singer('A0123', 'Taylor Swift', 28, 170, 72);
  print(singer);
  singer.sing("Cause we're young, and we're reckless We'll take this way too far It'll leave you breathless ...");

}

Future<void> testFutureAndStream() async {
  //Future
  // print('Login Page: \n');
  // Login('admin', '123');

  //Stream
  print('Login');
  Stream<bool> stream = Stream.fromFuture(ValidAccount('admin', '123')).asBroadcastStream();
  stream.listen((event) {
    if(event){
      print('Login successful!');
    }
    else{
      print('Login unsuccessful!');
    }
  });
  stream.listen((event) {
    if(event){
      print('Login successful!');
    }
    else{
      print('Login unsuccessful!');
    }
  });

  print('Display singer list:');
  Iterable<Singer> singers = [
    Singer('A', 'Justin Bieber', 32, 180, 72),
    Singer('B', 'Taylor Swift', 36, 173, 50),
    Singer('C', 'Sơn Tùng M-TP', 30, 170, 72),
    Singer('D', 'MCK', 26, 175, 70)
  ];
  //
  Stream<Singer> streamIterible = Stream.fromIterable(singers);
  streamIterible.listen((data){
    print(data);
  });
}

Future<bool> ValidAccount(String account, String password) async {

  await Future.delayed(const Duration(seconds: 2));
  return account == 'admin' && password == '123';
}
Future<void> Login(String account, String password) async {
  try {
    print('Loading... \n');
    var result = await ValidAccount(account, password);
    print('Login result: ${result? 'successful':'invalid account!'}');
  } catch (e) {
    print("Error: login error !");
  }
}