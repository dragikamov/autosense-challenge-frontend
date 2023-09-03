import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'package:dio/dio.dart';

class APIProvider {
  final Dio _dio = Dio();
  final String _url = 'http://10.0.2.2:4000/stations/';
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEyMzQ1Njc4OTAiLCJpYXQiOjE2OTM1OTY3MjksImV4cCI6MTY5Mzg1NTkyOX0.RzwzvOqju2GRCi7BtG3BP-mHvNLKwdiEz5QM7sQmIz8";

  Future<StationsModel> getStations() async {
    try {
      final response = await _dio.get(
        _url,
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      return StationsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
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
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
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
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
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
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return StationsModel.withError("Error deleting data");
    }
  }
}
