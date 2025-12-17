import 'package:pixelfield_test/utils/response_data_model/response_data_model.dart';

/// Generic API response parser utility
class ApiResponseParser {
  /// Parse any API response to ResponseDataModel<T>
  ///
  /// [json] - Raw API response
  /// [fromJson] - Function to convert JSON to model T
  /// [successMessage] - Optional success message (defaults to generic message)
  static ResponseDataModel<T> parse<T>({
    required dynamic json,
    required T Function(Map<String, dynamic>) fromJson,
    String? successMessage,
  }) {
    try {
      // Handle null or invalid response
      if (json == null) {
        return ResponseDataModel.error('Invalid response received');
      }

      final responseMap = json is Map<String, dynamic>
          ? json
          : throw const FormatException('Response is not a valid JSON object');

      final statusCode = responseMap['statusCode'] as int? ?? 0;
      final error = responseMap['error'] as String?;

      // Check for success
      if ((statusCode == 200 || statusCode == 201) && error == null) {
        final data = responseMap['data'];

        if (data == null) {
          return ResponseDataModel.error('No data found in response');
        }

        // Parse the data using the provided fromJson function
        final parsedData = fromJson(data as Map<String, dynamic>);

        return ResponseDataModel.success(
          parsedData,
          successMessage ?? 'Data loaded successfully',
        );
      } else {
        // Handle error response
        return ResponseDataModel.error(
          error ?? 'Request failed',
          statusCode: statusCode,
        );
      }
    } catch (e) {
      return ResponseDataModel.error(
        'Failed to parse response: $e',
      );
    }
  }

  /// Parse API response for boolean results (like signup, verify OTP, etc.)
  ///
  /// [json] - Raw API response
  /// [successMessage] - Optional success message
  static ResponseDataModel<bool> parseBooleanResponse({
    required dynamic json,
    String? successMessage,
  }) {
    try {
      if (json == null) {
        return ResponseDataModel.error('Invalid response received');
      }

      final responseMap = json is Map<String, dynamic>
          ? json
          : throw const FormatException('Response is not a valid JSON object');

      final statusCode = responseMap['statusCode'] as int? ?? 0;
      final error = responseMap['error'] as String?;

      if ((statusCode == 200 || statusCode == 201) && error == null) {
        return ResponseDataModel.success(
          true,
          successMessage ?? 'Operation completed successfully',
        );
      } else {
        return ResponseDataModel.error(
          error ?? 'Operation failed',
          statusCode: statusCode,
        );
      }
    } catch (e) {
      return ResponseDataModel.error(
        'Failed to parse response: $e',
      );
    }
  }

  /// Parse API response that returns a simple data field (like a string, number, etc.)
  ///
  /// [json] - Raw API response
  /// [dataKey] - Key to extract from data object (defaults to 'value')
  /// [successMessage] - Optional success message
  static ResponseDataModel<T> parseSimpleData<T>({
    required dynamic json,
    String dataKey = 'value',
    String? successMessage,
  }) {
    try {
      if (json == null) {
        return ResponseDataModel.error('Invalid response received');
      }

      final responseMap = json is Map<String, dynamic>
          ? json
          : throw const FormatException('Response is not a valid JSON object');

      final statusCode = responseMap['statusCode'] as int? ?? 0;
      final error = responseMap['error'] as String?;

      if (statusCode == 200 && error == null) {
        final data = responseMap['data'];

        if (data == null) {
          return ResponseDataModel.error('No data found in response');
        }

        final value = data is Map<String, dynamic>
            ? data[dataKey] as T?
            : data as T?;

        if (value == null) {
          return ResponseDataModel.error('Required data field not found');
        }

        return ResponseDataModel.success(
          value,
          successMessage ?? 'Data retrieved successfully',
        );
      } else {
        return ResponseDataModel.error(
          error ?? 'Request failed',
          statusCode: statusCode,
        );
      }
    } catch (e) {
      return ResponseDataModel.error(
        'Failed to parse response: $e',
      );
    }
  }
}
