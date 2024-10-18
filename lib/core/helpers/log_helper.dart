import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

void logInfo(String message) {
  GetIt.I<Talker>().info(message);
}

void logError(String message) {
  GetIt.I<Talker>().error(message);
}

void logDebug(String message) {
  GetIt.I<Talker>().debug(message);
}

void logWarning(String message) {
  GetIt.I<Talker>().warning(message);
}

void logCritical(String message) {
  GetIt.I<Talker>().critical(message);
}

void logHandle(String message, StackTrace st) {
  GetIt.I<Talker>().handle(message, st);
}