import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

final logger = Logger();

dynamic logDebugMessage({required String message}) {
  logger.d(message);
}

dynamic logErrorMessageCrashlytics(
    {required dynamic error, required String message}) {
  logger.e("## ERROR - $message", error: error);
  FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
}
