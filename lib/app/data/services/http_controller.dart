import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latihanmodul/app/data/models/article.dart' as ArticleModel;

class HttpController extends GetxController {
  RxList<ArticleModel.Article> articles = RxList<ArticleModel.Article>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await fetchArticles();
    super.onInit();
  }

  // https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d6da786eebd84ef281077ad9f94c19f1

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(
          'https://my-json-server.typicode.com/Fallid/codelab-api/db'));

      if (response.statusCode == 200) {
        final jsonData = response.body;
        final articlesResult =
            ArticleModel.MyJson.fromJson(json.decode(jsonData));
        articles.value = articlesResult.articles;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred :$e');
    } finally {
      isLoading.value = false;
    }
  }
}
