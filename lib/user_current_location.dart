import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocatiionScreen extends StatefulWidget {
  const GetUserCurrentLocatiionScreen({Key? key}) : super(key: key);



  @override
  State<GetUserCurrentLocatiionScreen> createState() => _GetUserCurrentLocatiionScreenState();
}

class _GetUserCurrentLocatiionScreenState extends State<GetUserCurrentLocatiionScreen> {

  Completer<GoogleMapController> _controller = Completer();

  static  CameraPosition _kLake = const CameraPosition(
      target: LatLng(7.427330, 80.217888),
      zoom: 19.151926040649414
  );

  final List<Marker> _marker = [];
  final List<Marker> _list = [

    Marker(
        markerId: MarkerId("1"),
        position: LatLng(7.427330, 80.217888),
        infoWindow: InfoWindow(
            title: 'My Place 1'
        )
    ),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  Future<Position> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kLake,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },

        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: (){
            getUserCurrentLocation().then((value) async{
              print("my current location");
              print(value.latitude.toString() +" "+ value.longitude.toString());

              _marker.add(
                Marker(markerId: MarkerId("2"),
                position:LatLng(value.latitude ,value.longitude),
                    infoWindow: const InfoWindow(
                    title: 'My Location'
                )
                )
              );

              CameraPosition cameraposition = CameraPosition(
                  target:LatLng(value.latitude ,value.longitude),
                  zoom: 14
              );

              final GoogleMapController controller = await _controller.future;
              
              controller.animateCamera(CameraUpdate.newCameraPosition(cameraposition));

              setState(() {

              });


            });
        },
      ),
    );
  }
}
