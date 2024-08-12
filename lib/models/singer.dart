import 'package:basics_of_dart/models/person.dart';

interface class ISing {
  void sing(String? lyrics){}
}

class Singer extends Person implements ISing {
  Singer(super.id, [super.name, super.age, super.heightCM, super.weightKG]);

  @override
  void sing(String? lyrics) {
    print('${this.name} sings: ${lyrics}');
  }
}