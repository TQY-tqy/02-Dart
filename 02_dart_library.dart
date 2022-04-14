//https://dart.cn/guides/libraries/library-tour#dartcore---numbers-collections-strings-and-more
void dartcore_numbers_numbers_collections_strings_and_more(){
  print('\n');
  print('#'*40);
  print("数字、集合、字符串等");
  print('*'*40);

 
  assert(int.parse('42') == 42);
  assert(int.parse('0x42') == 66);
  assert(int.parse('42',radix:16)=66);

// Convert an int to a string.
  assert(42.toString() == '42');
 // Specify the number of digits after the decimal.
  assert(123.456.toStringAsFixed(2) == '123.46');

  // Specify the number of significant figures.
  assert(123.456.toStringAsPrecision(2) == '1.2e+2');
  assert(double.parse('1.2e+2') == 120.0);

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




}

void main(){
  dartcore_numbers_numbers_collections_strings_and_more();
}