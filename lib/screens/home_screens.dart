import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
////import 'package:edelivery_driver/blocs/location_bloc.dart';
import 'package:edelivery_driver/components/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

enum onlineStatus{
  online,
  offline
}



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  Firestore firestore= Firestore.instance;
  Geoflutterfire geo= Geoflutterfire();
  StreamSubscription<LocationData> locationSubscription;
  double cameraTilt = 80;
  double cameraZoom = 16;
  double cameraBearing = 30;
  LocationData currentLocation;
  Location location;
  PermissionStatus _permissionGranted;
  var onlineStatusButtonList=[
    'you are offline',
    'you are online'
  ];
  var onlineStatButton;


  // Location location;
  // LocationData locationData;
  LatLng current;
  bool _serviceEnabled;
  static LatLng currLoc = LatLng(48.864716, 2.349014);
  String searchAddress;
  final CameraPosition kGooglePlex = CameraPosition(
    target:
    currLoc, //LatLng(_currentPosition.latitude,_currentPosition.longitude)
    zoom: 14.4746,
  );
  @override
  void initState() {
    // TODO: implement initState
    //locationBloc=LocationBloc();
    // getUserLocation();
    //initPlatformState();
    location = Location();
    onlineStatButton=onlineStatusButtonList[0];
    locationSubscription = location.onLocationChanged.listen((LocationData cLoc) {
      setState(() {
        currentLocation = cLoc;
      });
    });
    setInitialLocation();
    super.initState();
  }

  void currentOnlineStatus(onlineStatus status){
        if(status==onlineStatus.offline){
          setState(() {
            onlineStatButton=onlineStatusButtonList[1];
          });
        }
        else if (status==onlineStatus.online){
           onlineStatButton=onlineStatusButtonList[0];
        }
  }


  @override
  Widget build(BuildContext context) {
    var currentCameraPosition = CameraPosition(
        zoom: cameraZoom,
        tilt: cameraTilt,
        bearing: cameraBearing,
        target:  LatLng(48.864716, 2.349014));

    if (currentLocation != null) {
      currentCameraPosition = CameraPosition(
          zoom: cameraZoom,
          tilt: cameraTilt,
          bearing: cameraBearing,
          target: LatLng(currentLocation.latitude,currentLocation.longitude));
    }


    return Scaffold(
      appBar: AppBar(title: Text('Nile Driver'),),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Stack(
        children: <Widget>[
          currentLocation==null ? Center(
            child: CircularProgressIndicator(),
          ) :
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: currentCameraPosition, // (GoogleMapController controller) async => _controller.complete(controller),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          ),
          Positioned(
            bottom: 20.0,
            child: RaisedButton(
              onPressed: () {
                /*Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        RedeemConfirmationScreen()));*/

                addGeoPoint();
                /* if(onlineStatButton==onlineStatusButtonList[0]){
                  currentOnlineStatus(onlineStatus.offline);
                }
                else{
                  currentOnlineStatus(onlineStatus.online);
                }*/

              },
              child: Text(onlineStatButton.toString(), style: TextStyle(fontSize: 20)),
            ),
          )
        ],
      ),
    );
  }

  /* Future<Position> locateUser() async {
    return Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
*/
  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();

  }
  Future getUserLocation() async {
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
    });
    //  currentLocation = await locateUser();
    setState(() {
      current = LatLng(currentLocation.latitude, currentLocation.longitude);
    });

    return current;
  }

  Future initPlatformState() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
        return null;
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
        return null;

    }
  }

  Future<DocumentReference> addGeoPoint() async{
    var pos= await location.getLocation();
    var  point= geo.point(latitude: pos.latitude , longitude: pos.longitude);
    return firestore.collection('locations').add({
        'point' : point.data,
         'name' :  'yah i am quired'
    });
  }
}



/*class RedeemConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
        body: Center(
          child: Text('Center'),
        ),
    );
  }}*/

