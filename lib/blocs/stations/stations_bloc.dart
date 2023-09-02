import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'package:autosense_challenge_frontend/resources/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stations_event.dart';
part 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  StationsBloc() : super(StationsInitial()) {
    final APIRepository apiRepository = APIRepository();

    on<GetStations>((event, emit) async {
      try {
        emit(StationsLoading());
        final StationsModel stationsModel = await apiRepository.getStations();
        emit(StationsLoaded(stationsModel: stationsModel));
        if (stationsModel.error != null) {
          emit(StationsError(message: stationsModel.error!));
        }
      } on NetworkError {
        emit(const StationsError(
            message: "Couldn't fetch data. Is the device online?"));
      }
    });

    on<UpdateStation>((event, emit) async {
      try {
        final StationsModel stationsModel =
            await apiRepository.updateStation(event.station);
        if (stationsModel.error != null) {
          emit(StationsError(message: stationsModel.error!));
        }
      } on NetworkError {
        emit(const StationsError(
            message: "Couldn't update station. Is the device online?"));
      }
    });

    on<DeleteStation>((event, emit) async {
      try {
        final StationsModel stationsModel =
            await apiRepository.deleteStation(event.station);

        add(GetStations());

        if (stationsModel.error != null) {
          emit(StationsError(message: stationsModel.error!));
        }
      } on NetworkError {
        emit(const StationsError(
            message: "Couldn't delete station. Is the device online?"));
      }
    });
  }
}
