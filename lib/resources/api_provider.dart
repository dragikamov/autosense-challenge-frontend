import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'package:dio/dio.dart';

class APIProvider {
  final Dio _dio = Dio();
  final String _url = 'http://10.0.2.2:4000/stations/';

  Future<StationsModel> getStations() async {
    try {
      final response = await _dio.get(
        _url,
        options: Options(
          headers: {
            'Authorization':
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEyMzQ1Njc4OTAiLCJpYXQiOjE2OTM1OTY3MjksImV4cCI6MTY5Mzg1NTkyOX0.RzwzvOqju2GRCi7BtG3BP-mHvNLKwdiEz5QM7sQmIz8"
          },
        ),
      );
      return StationsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return StationsModel.withError("Data not found / Connection issue");
    }
  }
}
