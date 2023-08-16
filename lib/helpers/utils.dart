import 'package:logger/logger.dart';

abstract class Utils {
  static var logger = Logger(
    printer: PrettyPrinter(
      printEmojis: true,
      colors: true,
      printTime: false,
    ),
  );

  static loggerCustom({bool printEmojis = false, bool printTime = false}) =>
      Logger(
        printer: PrettyPrinter(
          printEmojis: printEmojis,
          colors: true,
          printTime: printTime,
        ),
      );
}
