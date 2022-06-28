// 命令行程序 https://dart.cn/tutorials/server/cmdline

import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

const lineNumber = 'line-number';

Future<void> dcat(List<String> paths, {bool showLineNumbers = false}) async {
  if (paths.isEmpty) {
    print('type exit to quit.');
    while (true) {
      stdout.write(
          '>>>'); // 这样可以不换行 https://stackoverflow.com/questions/14073217/print-without-a-newline-in-dart
      String? line = stdin.readLineSync();
      print('${line}\n');

      if (line?.toLowerCase() == 'exit') {
        //修改终止条件
        print('bye.');
        break;
      }
    }
  } else {
    for (final path in paths) {
      var lineNumber = 1;
      final lines = utf8.decoder
          .bind(File(path).openRead())
          .transform(const LineSplitter());

      try {
        await for (final line in lines) {
          if (showLineNumbers) {
            stdout.write('${lineNumber++} ');
          }
          stdout.writeln(line);
        }
      } catch (_) {
        await _handleError(path);
      }
    }
  }
}

Future<void> _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('Error: $path is a directory.');
  } else {
    exitCode = 2;
  }
}

void main(List<String> args) {
  exitCode = 0;
  final parser = ArgParser()..addFlag(lineNumber, negatable: false, abbr: 'n');

  ArgResults argResults = parser.parse(args);

  final paths = argResults.rest; // 剩余的命令行参数

  dcat(paths, showLineNumbers: argResults[lineNumber] as bool);
}
