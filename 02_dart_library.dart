//https://dart.cn/guides/libraries/library-tour#dartcore---numbers-collections-strings-and-more
import 'dart:collection';
import 'dart:math';
import 'dart:convert';

// 数字、集合、字符串(https://dart.cn/guides/libraries/library-tour#dartcore---numbers-collections-strings-and-more)
void Numberscollectionsstrings(){
  assert(int.parse('42') == 42);
  assert(int.parse('0x42') == 66);
  assert(int.parse('42',radix:16)==66);

// Convert an int to a string.
  assert(42.toString() == '42');
 // Specify the number of digits after the decimal.
  assert(123.456.toStringAsFixed(2) == '123.46');

  // Specify the number of significant figures.
  assert(123.456.toStringAsPrecision(2) == '1.2e+2');
  assert(double.parse('1.2e+2') == 120.0);

  /*String的一些基本方法*/
  //Check whether a string contains another string.
  assert('Never odd or even'.contains('odd'));

  // Does a string start with another string?
  assert('Never odd or even'.startsWith('Never'));

  // Does a string end with another string?
  assert('Never odd or even'.endsWith('even'));

  // Find the location of a string inside a string.
  assert('Never odd or even'.indexOf('odd') == 6);

  // Grab a substring.
  assert('Never odd or even'.substring(6, 9) == 'odd'); 

  var sample = 'Never odd or even';

  var parts = sample.split(' ');
  assert(parts.length == 4);
  assert(parts[0] == 'Never');

  assert(sample[0] == 'N');

  // split参数留空会将每个字符分开
  for (final char in 'BEAUTIFUL'.split('')) {
    print(char);
  }

  // 字符串的codeUnits属性
  var codeUnitList = sample.codeUnits.toList();
  assert(codeUnitList[0] == 78);

  assert('web apps'.toUpperCase() == 'WEB APPS');
  assert('WEB APPS'.toLowerCase() == 'web apps');
  assert('  hello   '.trim() == 'hello');
  // 判断是否为空字符串
  assert(''.isEmpty);
  assert('  '.isNotEmpty);

  var greetingTemplate = 'Hello, NAME!';
  var greeting = greetingTemplate.replaceAll(RegExp('NAME'), 'George');

  assert(greeting != greetingTemplate);

  var sb = StringBuffer();
  sb
    ..write('Use a StringBuffer for ')
    ..writeAll(['efficient', 'string', 'creation'], ' ')
    ..write('.');

  var fullString = sb.toString();
  assert(fullString == 'Use a StringBuffer for efficient string creation.');

  // 正则测试
  // 匹配一个或多个数字
  var numbersRe = RegExp(r'\d+');
  var allCharacters = 'llamas live fifteen to twenty years';
  var someDigits = 'llamas live 15 to 20 years';

  assert(!allCharacters.contains(numbersRe));
  assert(someDigits.contains(numbersRe));
}

void NUMBER(){
    print('数字、集合、字符串');
    print('*' * 40);
    Numberscollectionsstrings();
    print('*' * 40);
}

// 集合 (https://dart.cn/guides/libraries/library-tour#collections)
// 测试dart中列表的操作
void the_lists() {
  var grains = <String>[];
  assert(grains.isEmpty);

  var fruits = ['apples', 'oranges'];
  fruits.add('pineapples');
  fruits.addAll(['grapes', 'bananas']);

  fruits.insert(0, 'peach'); // 插在第一个位置上
  assert(fruits.length == 6);

  var appleIndex = fruits.indexOf('apples');
  fruits.removeAt(appleIndex);
  assert(fruits.length == 5);
  fruits.clear();
  assert(fruits.isEmpty);

  var vegetables = List.filled(99, 'broccoli');
  assert(vegetables.every((element) => element == 'broccoli'));

  fruits = ['bananas', 'apples', 'oranges'];
  // 进行排序，排序规则需要以函数为参数传入
  fruits.sort((a, b) => a.compareTo(b)); 
  assert(fruits[0] == 'apples');
  fruits = <String>[];
  fruits.add('apples');
  var fruit = fruits[0];
  assert(fruit is String);
}

void the_sets() {
  var ingredients = <String>{};
  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.length == 3);

  // 在集合中添加已有元素，不会有任何效果
  ingredients.add('gold');
  assert(ingredients.length == 3);

  ingredients.remove('gold');
  assert(ingredients.length == 2);

  // 使用Set的from构造函数
  var atomicNumbers = Set.from([1, 2, 3]);
  assert(atomicNumbers.length == 3);

  ingredients.clear();
  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.contains('titanium'));
  assert(ingredients.containsAll(['titanium', 'xenon']));

  ingredients.clear();
  ingredients.addAll(['gold', 'titanium', 'xenon']);

  // 集合的一些基本运算
  var nobelGases = Set.from(['xenon', 'argon']);
  var intersection = ingredients.intersection(nobelGases);
  assert(intersection.length == 1);
  assert(intersection.contains('xenon'));
}

void the_maps() {
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  var searchTerms = Map();
  var nobleGases = Map<int, String>(); // 规定键的类型
  nobleGases = {54: 'xenon'};
  assert(nobleGases[54] == 'xenon');
  assert(nobleGases.containsKey(54));

  // 删除Map中的键值对
  nobleGases.remove(54);
  assert(!nobleGases.containsKey(54));

  // 获得Map的所有键的Iterator
  var keys = hawaiianBeaches.keys;
  assert(keys.length == 3);
  assert(Set.from(keys).contains('Oahu'));

  // 获得Map的所有值的Iterator
  var values = hawaiianBeaches.values;
  assert(values.length == 3);
  assert(values.any((element) => element.contains('Kailua')));

  hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };
  assert(hawaiianBeaches.containsKey('Oahu'));
  assert(!hawaiianBeaches.containsKey('Florida'));

  var teamAssignments = <String, String>{};
  String pickToughestKid() {
    return "pickToughestKid";
  }

  teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());
  assert(teamAssignments['Catcher'] != null);
}

void public_methods() {
  // 一些通用的公共方法测试
  var coffees = <String>[];
  var teas = ['green', 'black', 'chamomile', 'earl grey'];
  assert(coffees.isEmpty);
  assert(teas.isNotEmpty);
  teas.forEach((element) => print('I drink $teas'));

  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  hawaiianBeaches.forEach((key, value) {
    print("I want to visit $key and swim at $value");
  });

  teas = ['green', 'black', 'chamomile', 'earl grey'];
  // 和JavaScript中的map用法一样
  var loudTeas = teas.map((tea) => tea.toUpperCase());
  loudTeas.forEach(print);
  var loadTeas_str = loudTeas.toList();
  print(loadTeas_str);
  // 用匿名函数创建函数
  bool isDecaffeinated(String teaName) => teaName == 'chamomile';
  // 查询方
  var decaffeinatedTeas = teas.where((tea) => isDecaffeinated(tea));
  assert(teas.any(isDecaffeinated));
  assert(!teas.every(isDecaffeinated));
}

void LIST(){
  print('集合');
  print('*' * 40);
  the_lists();
  the_sets();
  the_maps();
  public_methods();
  print('*' * 40);
}

// 异常(https://dart.cn/guides/libraries/library-tour#exceptions)
class FooException implements Exception {
  final String? msg;
  const FooException([this.msg]);
  @override
  String toString() => msg ?? 'FooException';
}

void exception_test(bool t) {
  print('6' * 66);
  print('异常类测试');
  if (!t) {
    throw FooException('This is an exception msg');
  }
}

// 异步编程 (https://dart.cn/guides/libraries/library-tour#dartasync---asynchronous-programming)
Future<Function> findEntryPoint() async {
  await Future.delayed(Duration(seconds: 3));
  return print;
}

// 以args为参数执行exec函数
Future<int> runExecutable(exec, args) async {
  exec(args);
  return 0;
}

// 分析exit code，此处直接输出一下
Future<void> flushThenExit(code) async {
  print('exit with code $code');
}

// 使用then链式回调按顺序执行异步函数
void runUsingFuture() {
  findEntryPoint().then((entryPoint) {
    return runExecutable(entryPoint, "using then to callback.");
  }).then(flushThenExit);
}

// 使用await可以写出类似于同步的异步代码
Future<void> runUsingAsyncAwait() async {
  var entryPoint = await findEntryPoint();
  try {
    var exitCode = await runExecutable(entryPoint, 'using await to callback.');
    await flushThenExit(exitCode);
  } catch (e) {}
}

Future<void> throw_error_future(bool flag) async {
  if (!flag) {
    throw FooException('Exception in async function.');
  } else {
    print('No throwing Exception in async function.');
  }
}

// catch异步函数中抛出的异常
void catch_error(bool flag) {
  throw_error_future(flag).then((_) {}).catchError((e) {
    print(e);
  });
}

// 测试各种异步操作
void error_test() {
  print('*' * 40);
  print('异步Future测试');
  runUsingFuture();
  runUsingAsyncAwait();
  catch_error(false);
  print('*' * 40);
}


//日期和时间  (https://dart.cn/guides/libraries/library-tour#dates-and-times)
void dates_and_times() {
  var now = DateTime.now(); //获得现在时间
  print('现在时间为：$now');

// Create a new DateTime with the local time zone.
//设置一个时间
  var y2k = DateTime(2000); // January 1, 2000

//确切的年月日
  y2k = DateTime(2000, 1, 2); // January 2, 2000

//确切的UTC时间
  y2k = DateTime.utc(2000); // 1/1/2000, UTC

  y2k = DateTime.fromMillisecondsSinceEpoch(946684800000, isUtc: true);

  y2k = DateTime.parse('2000-01-01T00:00:00Z');

  y2k = DateTime.utc(2000);
  assert(y2k.millisecondsSinceEpoch == 946684800000);

  var unixEpoch = DateTime.utc(1970);
  assert(unixEpoch.millisecondsSinceEpoch == 0);

  y2k = DateTime.utc(2000);

// 时间加上一年
  var y2001 = y2k.add(const Duration(days: 366));
  assert(y2001.year == 2001);

// 减去三十天
  var december2000 = y2001.subtract(const Duration(days: 30));
  assert(december2000.year == 2000);
  assert(december2000.month == 12);

// Calculate the difference between two dates.
// Returns a Duration object.
  var duration = y2001.difference(y2k);
  assert(duration.inDays == 366); // y2k was a leap year.
  print('y2k was a leap year.');
  print('The test of Dates_and_times is OK');
}

void Dates_and_times() {
  print('*' * 40);
  print('Dates_and_times');
  dates_and_times();
  print('*' * 40);

}


//URIs https://dart.cn/guides/libraries/library-tour#uris
void uri_test() {
  print('URI');
  // 测试URI类的常用功能
  var uri = 'https://www.bilibili.com/video/BV1qi4y177XH/?spm_id_from=333.788.recommend_more_video.-1&vd_source=e885054711e37b29f745c5187eaca309';
  print('原始URI：$uri');

  // 将除了/:&#外的字符都进行编码，以生成一个合法可用的URI
  var encoded = Uri.encodeFull(uri);
  print('encodeFull得到的：$encoded\n');
  assert(encoded == 'https://www.bilibili.com/video/BV1qi4y177XH/?spm_id_from=333.788.recommend_more_video.-1&vd_source=e885054711e37b29f745c5187eaca309');
  // 反向操作解码
  var decoded = Uri.decodeFull(encoded);
  print('decoded:$decoded\n');
  assert(decoded == 'https://www.bilibili.com/video/BV1qi4y177XH/?spm_id_from=333.788.recommend_more_video.-1&vd_source=e885054711e37b29f745c5187eaca309');

  // 将所有字符都编码
  encoded = Uri.encodeComponent(uri);
  print("encodeComponent得到的：$encoded\n");
  assert(encoded ==
      'https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1qi4y177XH%2F%3Fspm_id_from%3D333.788.recommend_more_video.-1%26vd_source%3De885054711e37b29f745c5187eaca309');
  decoded = Uri.decodeComponent(encoded);
  print('decoded:$decoded\n');
  assert(decoded == 'https://www.bilibili.com/video/BV1qi4y177XH/?spm_id_from=333.788.recommend_more_video.-1&vd_source=e885054711e37b29f745c5187eaca309');

}

void URI(){
  print('*' * 40);
  print('Dates_and_times');
  print('*' * 40);
  dates_and_times();
}

//dart:math - 数学和随机数
//（https://dart.cn/guides/libraries/library-tour#dartmath---math-and-random）

//三角函数
void Trigonometry() {
  //Math 库提供基本的三角函数：

  // Cosine
  assert(cos(pi) == -1.0);
  var cos_pi = cos(pi);
  print('cos(Π)=$cos_pi');
  // Sine
  var degrees = 30;
  var radians = degrees * (pi / 180);
  //弧度是0.52359.
  var sinOf30degrees = sin(radians);
  print('sin(30°)=$sinOf30degrees');
  //sin 30° = 0.5
  assert((sinOf30degrees - 0.5).abs() < 0.01);
  if ((sinOf30degrees - 0.5).abs() < 0.01) {
    print('sin(30°)=0.5');
  }
}

//最大值和最小值 
void Maximum_and_minimum() {
  //可以用max或min来求最值，函数在Math库里面
  assert(max(1, 1000) == 1000);
  var max_number = max(1, 1000);
  print('1和1000两数中较大者为：$max_number');

  assert(min(1, -1000) == -1000);
  var min_number = min(1, 1000);
  print('1和1000两数中较小者为：$min_number');
}

//数学常数 
void Math_constants() {
  print('规定常数e为：');
  print(e); // 2.718281828459045
  print('规定常数Π为：');
  print(pi); // 3.141592653589793
  print('规定常数根号2为：');
  print(sqrt2); // 1.4142135623730951
}

//随机数 
void Random_numbers() {
  //使用 Random 类产生随机数。可以为 Random 构造函数提供一个可选的种子参数。
  var random = Random();
  var random1 = random.nextDouble(); // Between 0.0 and 1.0: [0, 1)
  print(random1);
  var random2 = random.nextInt(10); // Between 0 and 9.
  print(random2);

  //也可以产生随机布尔值序列：
  var random3 = random.nextBool(); // true or false
  print(random3);
}

void dart_math() {
  print('*' * 40);
  print('dart_math - 数学和随机数');
  Maximum_and_minimum();
  Math_constants();
  Random_numbers();
  print('*' * 40);
}

// 工具类（https://dart.cn/guides/libraries/library-tour#utility-classes）
class Line implements Comparable<Line> {
  final int length;
  const Line(this.length);
  @override
  int compareTo(Line other) => length - other.length;
}

class Person {
  final String firstName, lastName;
  Person(this.firstName, this.lastName);
  @override
  int get hashCode => Object.hash(firstName, lastName);
  @override
  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      lastName == other.lastName;
}

class Process {
  int _uid;
  Process(this._uid);
  int get uid => _uid;
}

// 作为Processes的迭代器
class ProcessIterator implements Iterator<Process> {
  List<Process> list;
  int index = -1;
  ProcessIterator(this.list);
  @override
  Process get current => list[index];
  @override
  bool moveNext() => (++index) < list.length;
}

class Processes extends IterableBase<Process> {
  List<Process> process;
  Processes(this.process);
  @override
  Iterator<Process> get iterator => ProcessIterator(this.process);
}

void utility_test() {
  print('*' * 40);
  print('工具类测试：');
  // 实现了Comparable接口的类，用compareTo进行比较
  var short = Line(1);
  var long = Line(100);
  assert(short.compareTo(long) < 0);

  // 重写了hashCode的getter的类
  var p1 = Person('Bob', 'Smith');
  var p2 = Person('Bob', 'Smith');
  var p3 = 'not a person';
  assert(p1.hashCode == p2.hashCode);
  assert(p1 == p2);
  assert(p1 != p3);

  // 测试有Iterator的类
  var pr1 = Process(1);
  var pr2 = Process(2);
  Processes processes = Processes([pr1, pr2]);
  print('迭代器');
  for (Process p in processes) {
    print(p.uid);
  }
  print('*' * 40);
}

void main(){
  NUMBER();
  LIST();
  error_test();
  Dates_and_times();
  URI();
  dart_math();
  utility_test();
}