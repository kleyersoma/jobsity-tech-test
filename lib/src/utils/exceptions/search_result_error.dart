import 'dart:developer';

class SearchResultError implements Exception {
  SearchResultError({required this.message}) {
    log('Error: $message');
  }
  factory SearchResultError.fromJson(Map<String, dynamic> json) {
    return SearchResultError(
      message: json['error'] as String,
    );
  }

  final String message;
}
