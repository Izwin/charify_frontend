import 'package:charify_front/core/api/api_config.dart';

class UrlUtils{
  static String buildImageUrl(String filename){
    return "${ApiConfig.BASE_URL}uploads/$filename";
  }
}