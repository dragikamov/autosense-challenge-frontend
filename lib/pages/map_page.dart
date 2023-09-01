import 'package:autosense_challenge_frontend/blocs/stations/stations_bloc.dart';
import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final CameraPosition initialCameraPosition;

  const MapPage({
    super.key,
    this.initialCameraPosition = const CameraPosition(
      target: LatLng(46.8679, 8.2502),
      zoom: 8,
    ),
  });

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final StationsBloc _stationsBloc = StationsBloc();
  late CameraPosition _initialCameraPosition;

  GoogleMapController? _googleMapController;

  @override
  void initState() {
    super.initState();
    _stationsBloc.add(GetStations());
    _initialCameraPosition = widget.initialCameraPosition;
    getCurrentLocation();
  }

  @override
  void dispose() {
    _stationsBloc.close();
    _googleMapController?.dispose();
    super.dispose();
  }

  Future<LocationData?> getLocationPermissions() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted &&
          permissionGranted != PermissionStatus.grantedLimited) {
        return null;
      }
    }
    location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 10);
    locationData = await location.getLocation();

    return locationData;
  }

  Future<void> getCurrentLocation() async {
    LocationData? locationData = await getLocationPermissions();
    if (locationData != null) {
      _googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 11,
          ),
        ),
      );
    } else {
      // TODO: Show alert dialog for not allowing location permissions
      // SharedService.showAlertDialog(
      //   context,
      //   AppLocalizations.of(context)!.warning,
      //   AppLocalizations.of(context)!.location_permission_required,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Stations'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: BlocProvider(
            create: (_) => _stationsBloc,
            child: BlocListener<StationsBloc, StationsState>(
              listener: (context, state) {
                if (state is StationsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: BlocBuilder<StationsBloc, StationsState>(
                builder: (context, state) {
                  if (state is StationsInitial || state is StationsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StationsLoaded) {
                    return Scaffold(
                      body: GoogleMap(
                        initialCameraPosition: _initialCameraPosition,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        mapToolbarEnabled: false,
                        onMapCreated: (controller) =>
                            _googleMapController = controller,
                        markers: state.stationsModel.stations
                            ?.map(
                              (Station e) => Marker(
                                markerId: MarkerId(e.idName!),
                                position: LatLng(e.latitude!, e.longitude!),
                                infoWindow: InfoWindow(
                                  title: e.name,
                                  snippet: e.address,
                                  onTap: () {
                                    // TODO: Show station details
                                    print(e.name! + " InfoWindow tapped");
                                  },
                                ),
                              ),
                            )
                            .toSet() as Set<Marker>,
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                              heroTag: "MyLocationButton",
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              foregroundColor: Theme.of(context).primaryColor,
                              onPressed: () {
                                getCurrentLocation();
                              },
                              child: Icon(
                                Icons.my_location,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 55,
                              width: 100,
                              child: FloatingActionButton(
                                heroTag: "AddButton",
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  // TODO: ADD STATION ACTION
                                },
                                child: Text(
                                  "Add Station",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 55,
                              width: 55,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is StationsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
