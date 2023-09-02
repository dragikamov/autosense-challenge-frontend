import 'package:autosense_challenge_frontend/blocs/stations/stations_bloc.dart';
import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'package:autosense_challenge_frontend/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  final Station station;

  const DetailsPage({
    Key? key,
    required this.station,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.station.name!),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.station.name!,
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "${widget.station.address!}, ${widget.station.city!}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Latitude: ${widget.station.latitude}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Longitude: ${widget.station.longitude}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Pumps:",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(
                      "${widget.station.pumps[index].fuelType} - ${widget.station.pumps[index].price}");
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: widget.station.pumps.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: MyButton(
                    widget: const Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.green[300]!,
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: MyButton(
                    widget: const Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.red[300]!,
                    onPressed: () {
                      BlocProvider.of<StationsBloc>(context).add(
                        DeleteStation(station: widget.station),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
