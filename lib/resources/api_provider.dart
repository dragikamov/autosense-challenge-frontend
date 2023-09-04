import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'package:dio/dio.dart';

// This class is used to make API calls
class APIProvider {
  final Dio _dio = Dio();
  // TODO: Change this to `10.0.2.2:4000/stations` if using an emulator and localhost API
  final String _url = 'http://209.38.228.119:4000/stations/';
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEyMzQ1Njc4OTAiLCJpYXQiOjE2OTM4NTExNTcsImV4cCI6MTY5NDQ1NTk1N30.Yp6ZvZwIZNCe6Hkj0m1ruwaFcCo1CYUP_ZlvI-GwDlM";

  Future<StationsModel> getStations() async {
    try {
      final response = await _dio.get(
        _url,
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      return StationsModel.fromJson(response.data);
    } catch (error) {
      return StationsModel.withError("Data not found / Connection issue");
    }
  }

  Future<StationsModel> updateStation(Station station) async {
    try {
      final response = await _dio.put(
        _url + station.id.toString(),
        data: station.toJson(),
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      return StationsModel.fromJson(response.data);
    } catch (error) {
      return StationsModel.withError("Error updating data");
    }
  }

  Future<StationsModel> createStation(Station station) async {
    try {
      final response = await _dio.post(
        _url,
        data: station.toJson(),
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      return StationsModel.fromJson(response.data);
    } catch (error) {
      return StationsModel.withError("Error creating station");
    }
  }

  Future<StationsModel> deleteStation(Station station) async {
    try {
      final response = await _dio.delete(
        _url + station.id.toString(),
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      return StationsModel.fromJson(response.data);
    } catch (error) {
      return StationsModel.withError("Error deleting data");
    }
  }
}
