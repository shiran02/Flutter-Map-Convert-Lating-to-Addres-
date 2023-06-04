import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Completer<GoogleMapController> _completer = Completer();

  static  CameraPosition _kLake = const CameraPosition(
      target: LatLng(7.427330, 80.217888),
      zoom: 19.151926040649414
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const[

    Marker(
        markerId: MarkerId("1"),
        position: LatLng(7.427330, 80.217888),
      infoWindow: InfoWindow(
        title: 'My Place 1'
      )
    ),

    Marker(
        markerId: MarkerId("2"),
        position: LatLng(7.451060, 80.182440),
        infoWindow: InfoWindow(
            title: 'My Place 2'
        )
    )


  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kLake,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
            _completer.complete(controller);
          },

        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: () async{
        GoogleMapController controller = await _completer.future ;
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target:LatLng(7.427330, 80.217888),
              zoom: 14
            )
        ));

        setState(() {

        });
        },
      ),
    );
  }
}
