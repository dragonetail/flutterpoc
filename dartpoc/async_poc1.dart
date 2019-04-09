Future delayTest1() async {
  return Future.delayed(new Duration(milliseconds: 300), () {
    print('In delayTest1.');
  });
}

Future delayTest2() async {
  return Future.delayed(new Duration(milliseconds: 100), () {
    print('In delayTest2.');
  });
}

void execute() async {
  print('Before delayTest...');
  Future future = delayTest1();
  print('After delayTest...');
  await future;
  print('End...');
}

void main()  {
  print('Before execute...');
  execute();
  delayTest2();
  print('After execute...');
}
