import 'package:benfica_social/services/base_service.dart';

String formatImageUrl(String filePath) {
  // Extract the filename from the file path
  String fileName = filePath.split('/').last;

  // Construct the base URL
  String baseUrl = "${skeltonUrl}/uploads/";

  // Return the full URL
  return "$baseUrl$fileName";
}