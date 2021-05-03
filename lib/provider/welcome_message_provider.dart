import 'dart:convert';
import 'package:app_tecnomotriz_check_in_out_time/models/welcome_message_model.dart';
import 'package:http/http.dart' as http;

class WelcomeMessageProvider {
  static final String _apiKey = 'wqE6Uf9aqRa9QPw9ZMrtvc9lkyTwFEqe';
  static final String _baseURL = 'simplesolutionscr.com';
  static final String _endpoint = 'tecnomotriz/webservice/service.php';

  Future<Map<String, dynamic>> getWelcomeMessage() async {
    final url = Uri.https(_baseURL, _endpoint, {
      'who': 'get_mensaje',
      'api_key': _apiKey,
    });

    print('URL: {$url}');
    final response = await http.get(url, headers: {
      'Access-Control-Allow-Origin': '*',
    });
    WelcomeMessageModel message = new WelcomeMessageModel();

    try {
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      bool error = decodedResponse['error'];
      if (!error) {
        message = WelcomeMessageModel.fromJson(
            decodedResponse['respuesta'][0]);

        return {'error': false, 'message': message};
      } else {
        return {
          'error': true,
          'message':
              'Un error ha ocurrido, por favor verifique su acceso y señal de internet.'
        };
      }
    } catch (e) {
      print('An error has occurred: $e');
    } finally {
      print('Responce Status Code: ${response.statusCode}');
    }
  }
}
