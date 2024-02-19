import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab5/const.dart';
import 'package:lab5/models/exam_location.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  final List<ExamLocation> locations;

  const MapScreen({super.key, required this.locations});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool userLocationLoaded = false;

  Location locationController = Location();

  LatLng? currentLocation;

  Marker? currentLocationMarker;

  static const LatLng _cameraPosition =
      LatLng(41.991073882055744, 21.445443777271347);

  Set<Marker> markers = {};

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation != null) {
      markers.add(Marker(
          markerId: const MarkerId("initialPosition"),
          position: currentLocation!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition:
            const CameraPosition(target: _cameraPosition, zoom: 15),
        markers: markers,
        polylines: Set<Polyline>.of(polylines.values),
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> cametaToPosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15)));
  }

  void initMarkers() {
    for (ExamLocation location in widget.locations) {
      markers.add(Marker(
          markerId: MarkerId(location.name),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen)));
    }
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();

    if (!serviceEnabled) {
      return;
    }

    serviceEnabled = await locationController.requestService();

    permissionGranted = await locationController.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((LocationData currentLocation) {
      updateCurrentLocation(currentLocation);
    });
  }

  void updateCurrentLocation(LocationData currentLocation) {
    if (currentLocation.latitude == null || currentLocation.longitude == null) {
      return;
    }

    if (!userLocationLoaded) {
      setState(() {
        this.currentLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        userLocationLoaded = true;
        cametaToPosition(this.currentLocation!);
        getPolyLinePoints(
            LocationData.fromMap({
              "latitude": currentLocation.latitude,
              "longitude": currentLocation.longitude
            }),
            LocationData.fromMap({
              "latitude": widget.locations[0].latitude,
              "longitude": widget.locations[0].longitude
            })).then((points) => {gereratePolyline(points)});
      });
    }
  }

  Future<List<LatLng>> getPolyLinePoints(
      LocationData start, LocationData end) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_MAPS_API_KEY,
        PointLatLng(start.latitude!, end.longitude!),
        PointLatLng(
            widget.locations[0].latitude, widget.locations[0].longitude),
        travelMode: TravelMode.driving);
    return result.points.map((e) => (LatLng(e.latitude, e.longitude))).toList();
  }

  void gereratePolyline(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinates,
        width: 3);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
