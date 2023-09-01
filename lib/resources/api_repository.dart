import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'api_provider.dart';

class APIRepository {
  final _provider = APIProvider();

  Future<StationsModel> getStations() {
    return _provider.getStations();
  }
}

class NetworkError extends Error {}
