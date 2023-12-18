import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

    Future<List<dynamic>> getAdminsLogins() async{
        List<dynamic> admins = [];
        String uri = "${dotenv.env['API_URL']}/get_admins.php";
        try {
            var response = await http.get(Uri.parse(uri));

            if (response.statusCode == 200) {
                admins = json.decode(response.body);
            } else {
                print('Error en la solicitud: ${response.statusCode}');
            }
        } catch (e) {
            print(e);
        }
        return admins;
    }

    /*Future<void> getData() async{
        await getAdminsLogins();
        adminsList.addAll(admins);
    }*/
