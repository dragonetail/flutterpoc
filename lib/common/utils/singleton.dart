class MyClass {
  //单体实例
  static final MyClass _singleton = new MyClass._internal();

  //工厂模式 和 静态实例
  factory MyClass() => _singleton;
  static MyClass get instance => _singleton;

  //私有构造
  MyClass._internal() {
     // initialization logic here
  }

  // Rest of the class
}

// consuming code
// MyClass myObj1 =  MyClass(); 
// MyClass myObj2 =  MyClass.instance; 
