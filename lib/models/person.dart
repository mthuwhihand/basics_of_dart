class Person {
  /*late*/ final String? _id;
  String? _name;
  int? _age;
  int? _heightCM;
  double? _weightKG;

  // Person(this._id, String name, int age, int heightCM, double weightKG){
  //   this.name = name;
  //   this._age = age;
  //   this._heightCM = heightCM;
  //   this._weightKG = weightKG;
  // }
  Person(this._id, [this._name, this._age, this._heightCM, this._weightKG]);
  Person.Default(this._id){
    this._name = 'Bob';
    this._age = 18;
    this._heightCM = 170;
    this._weightKG = 60;
  }
  // Get
  String? get id => _id;
  String? get name => _name;
  int? get age => _age;
  int? get heightCM => _heightCM;
  double? get weightKG => _weightKG;


  // Set
  // set id(String? id) => _id = id; //dùng để test late với final
  set name(String? name) => _name = name;
  set age(int? age) => _age = age;
  set heightCM(int? heightCM) => _heightCM = heightCM;
  set weightKG(double? weightKG) => _weightKG = weightKG;

  void says(String? str){
    print('${this._name} says: ${str}');
  }

  String getTShirtSize(){
    if(this._heightCM == null || this._weightKG == null){
      return 'Can not get size';
    }
    if(this._heightCM! > 175 || this._weightKG! > 75){
      return 'XL';
    }
    if(this._heightCM! > 165 || this._weightKG! > 65){
      return 'L';
    }
    return 'M';
  }
  @override
  String toString() {
    return 'ID: $_id\nName: $_name\nAge: $_age\nHeight(cm): $_heightCM\nWeight: $_weightKG';
  }

}