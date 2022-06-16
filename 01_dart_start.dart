import 'dart:math';

//类{https://dart.cn/samples#classes}
class Spacecraft{
  String name;
  DateTime? launchDate;
  
  //只读非最终属性
  int? get launchYear => launchDate?.year;

  //构造函数
  Spacecraft(this.name, this.launchDate){

  }

  //命名
  Spacecraft.unlaunched(String name) :this(name, null);
  
  void describe(){
    print('Spacecraft: $name');

    var launchDate = this.launchDate;
    if(launchDate != null){
      int years = DateTime.now().difference(launchDate).inDays~/365;
      print('Launched: $launchYear($years years ago)');
    }else{
      print('Unlaunched');
    }
  }

}

//继承类{https://dart.cn/samples#inheritance}
class Orbiter extends Spacecraft{
  double altitude;

  Orbiter(String name, DateTime launhDate, this.altitude)
  :super(name, launhDate);

}

//使用 Mixin 的方式继承这个类就可将该类中的功能添加给其它类
class PilotedCraft extends Spacecraft with Piloted{
  PilotedCraft(String name, DateTime launhDate)
  :super(name,launhDate);
}//自此，PilotedCraft 类中就包含了 astronauts 字段以及 describeCrew() 方法。

//接口和抽象类{https://dart.cn/samples#interfaces-and-abstract-classes}

 abstract class Describable {//抽象类
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

//变量 {https://dart.cn/samples#variables}
void variables(){
    var name = 'Tang Qingyong';
    var year = 2002;
    var antennaDiameter = 3.7;
    var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune','Voyager I'];
    var image = {
        'tags': ['saturn'],
        'url':'//path/to/saturn.jpg'
    };
    //$+变量名 即可打印其内容
    print('name is $name, year is $year, antennaDiamater is $antennaDiameter, flybyObjects is $flybyObjects, image is $image');
    
    //流程控制语句
    if(year >= 2001) print('born in 21st century');
    else if(year >= 1901) print('born in 20th century');

    print('flybyObjects');
    for(final object in flybyObjects){
      print(object);
    }

    print('output every month');
    for(int month = 1; month <=12; month++) print(month);

    while(year <= 2016){
      year += 1;
    }

    print('test year');
    print(year);

    print('test the method"=>"');
    flybyObjects.where((name) => name.contains('Voyager I')).forEach(print);//这里将print转给了forEach（）函数
}

//函数 {https://dart.cn/samples#functions}
int fibonacci(int n){
  if(n == 0||n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

//Minxins(一种在多个类层次结构中重用代码的方法) {https://dart.cn/samples#mixins}
mixin Piloted{
  int astronauts = 1;

  void describeCrew(){
     print('Number of astronauts: $astronauts');
  }

}

void test_math(){
  //测试math
  double ans = exp(5);
  double ans_1 = max(999,888);

  print('the answer of e^5 is $ans');
  print('the bigger one of 999 and 888 is $ans_1');

  print('test the class Spacecraft');

}

void test_class(){
  //测试class
  //使用Spacecraft类
  var tqy = Spacecraft('Tang Qingyong', DateTime(2002,10,20));
  tqy.describe();

  var tqy3 = Spacecraft.unlaunched('the daughter of tqy');
  tqy3.describe();

  //使用Orbiter类
  var tjc = Orbiter('tjc', DateTime(2012,3,4), 10);
  tjc.describe();

  //使用PilotedCraft类以及测试Mixins功能
  var xtjc = PilotedCraft('xtjc', DateTime(2016,4,5));
  xtjc.describe();
  xtjc.describeCrew();

}

Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

Future<void> async_test() async{
  List<Future<void>> fList = [];
  for (int i = 0; i < 10; i++) {
    fList.add(printWithDelay("hello" + i.toString()));
  }
  await Future.wait(fList);
}

Future<void> sync_test() async {
  for (int i = 0; i < 10; i++) {
    await printWithDelay("hello" + i.toString());
  }
}

void test_exception() {
  PilotedCraft pilotedCraft = PilotedCraft("Pilot II", DateTime(2022, 3, 1));
  pilotedCraft.setAstronauts = 0;
  try {
    pilotedCraft.describeCrew();
  } on StateError catch (e) {
    print("Can not describe object $e");
  }
}

Future<void> test_exception2() async {
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  try {
    for (final object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print("Could not describe object: $e");
  } finally {
    flybyObjects.clear();
  }
}

void main(){
  var result = fibonacci(20);//测试斐波那契函数
  print('result is $result');
  //（胖箭头）简写语法用于仅包含一条语句的函数。
  variables();//输出各变量，测试循环功能

  test_math();//测试引入的math包
  test_class();//测试类

  print("\n----------同步/异步对比测试------------\n");
  print("异步操作：\n");
  timeStamp = DateTime.now().millisecondsSinceEpoch;
  await async_test();
  print("异步操作用时：${DateTime.now().millisecondsSinceEpoch - timeStamp}ms\n");
  print("同步操作：\n");
  timeStamp = DateTime.now().millisecondsSinceEpoch;
  await sync_test();
  print("同步操作用时：${DateTime.now().millisecondsSinceEpoch - timeStamp}ms\n");
  
}