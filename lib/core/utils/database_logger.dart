import 'package:altsome_app/core/utils/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Database operation logging utility
/// Provides comprehensive logging for all database operations
class DatabaseLogger {
  /// Logs a database query operation
  static void logQuery({
    required String table,
    required String operation,
    Map<String, dynamic>? filters,
    List<String>? columns,
    Map<String, dynamic>? data,
    String? additionalInfo,
  }) {
    final logMessage = StringBuffer();
    logMessage.write('DB Query - Table: $table, Operation: $operation');

    if (columns != null && columns.isNotEmpty) {
      logMessage.write(', Columns: ${columns.join(", ")}');
    }

    if (filters != null && filters.isNotEmpty) {
      logMessage.write(', Filters: $filters');
    }

    if (data != null && data.isNotEmpty) {
      logMessage.write(', Data: $data');
    }

    if (additionalInfo != null) {
      logMessage.write(', Info: $additionalInfo');
    }

    AppLogger.logger.d(logMessage.toString());
  }

  /// Logs a successful database operation result
  static void logSuccess({
    required String table,
    required String operation,
    dynamic result,
    int? recordCount,
    String? additionalInfo,
  }) {
    final logMessage = StringBuffer();
    logMessage.write('DB Success - Table: $table, Operation: $operation');

    if (recordCount != null) {
      logMessage.write(', Records: $recordCount');
    }

    if (additionalInfo != null) {
      logMessage.write(', Info: $additionalInfo');
    }

    AppLogger.logger.i(logMessage.toString());

    // Log detailed result for debug level
    if (result != null) {
      AppLogger.logger.d('DB Result: $result');
    }
  }

  /// Logs a database operation error
  static void logError({
    required String table,
    required String operation,
    required dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    final logMessage = StringBuffer();
    logMessage.write('DB Error - Table: $table, Operation: $operation');

    if (context != null && context.isNotEmpty) {
      logMessage.write(', Context: $context');
    }

    AppLogger.logger
        .e(logMessage.toString(), error: error, stackTrace: stackTrace);
  }

  /// Logs authentication-related operations
  static void logAuth({
    required String operation,
    String? userId,
    String? email,
    bool success = true,
    dynamic error,
  }) {
    if (success) {
      AppLogger.logger.i(
          'Auth Success - Operation: $operation, User: ${userId ?? email ?? 'unknown'}');
    } else {
      AppLogger.logger.e(
          'Auth Failed - Operation: $operation, User: ${userId ?? email ?? 'unknown'}',
          error: error);
    }
  }

  /// Logs storage operations (file uploads, etc.)
  static void logStorage({
    required String operation,
    required String bucket,
    String? filePath,
    int? fileSize,
    bool success = true,
    dynamic error,
  }) {
    final logMessage = StringBuffer();
    logMessage.write(
        'Storage ${success ? 'Success' : 'Failed'} - Operation: $operation, Bucket: $bucket');

    if (filePath != null) {
      logMessage.write(', Path: $filePath');
    }

    if (fileSize != null) {
      logMessage.write(', Size: ${fileSize} bytes');
    }

    if (success) {
      AppLogger.logger.i(logMessage.toString());
    } else {
      AppLogger.logger.e(logMessage.toString(), error: error);
    }
  }

  /// Logs transaction operations
  static void logTransaction({
    required String operation,
    List<String>? tables,
    bool success = true,
    dynamic error,
    String? transactionId,
  }) {
    final logMessage = StringBuffer();
    logMessage.write(
        'Transaction ${success ? 'Success' : 'Failed'} - Operation: $operation');

    if (transactionId != null) {
      logMessage.write(', ID: $transactionId');
    }

    if (tables != null && tables.isNotEmpty) {
      logMessage.write(', Tables: ${tables.join(", ")}');
    }

    if (success) {
      AppLogger.logger.i(logMessage.toString());
    } else {
      AppLogger.logger.e(logMessage.toString(), error: error);
    }
  }

  /// Logs PostgreSQL-specific errors with enhanced context
  static void logPostgresError({
    required String table,
    required String operation,
    required PostgrestException error,
    Map<String, dynamic>? context,
  }) {
    final logMessage = StringBuffer();
    logMessage.write('PostgreSQL Error - Table: $table, Operation: $operation');
    logMessage.write(', Code: ${error.code}, Message: ${error.message}');

    if (error.details != null) {
      logMessage.write(', Details: ${error.details}');
    }

    if (error.hint != null) {
      logMessage.write(', Hint: ${error.hint}');
    }

    if (context != null && context.isNotEmpty) {
      logMessage.write(', Context: $context');
    }

    AppLogger.logger.e(logMessage.toString(), error: error);
  }
}
