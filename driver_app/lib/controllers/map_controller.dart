import 'dart:async';

import 'package:driver_app/modals/directionDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver_app/api/utils.dart';

import 'package:driver_app/modals/location.dart';
import 'package:driver_app/modals/place_details.dart';
import 'package:driver_app/utils/config.dart';

class MapController extends GetxController {
  var polyLineLoading = false.obs;
  RxList<LatLng> polyLineCoordinates = [LatLng(0, 0)].obs;
  RxSet<Polyline> polyLineSet = {Polyline(polylineId: PolylineId("value"))}.obs;
  RxSet<Marker> markersSet = {Marker(markerId: MarkerId("value"))}.obs;
  RxSet<Circle> circlesSet = {Circle(circleId: CircleId("value"))}.obs;
  late GoogleMapController newGoogleMapController;
  late Position currentPosition;

  Rx<DirectionDetails> directionDetails = DirectionDetails(
    distanceText: "0",
    durationText: "0",
    encodedPoints: "",
    distanceValue: 0,
    durationValue: 0,
  ).obs;

  var start = PlaceDetails(
    home: "",
    street: "",
    city: "",
    district: "",
    province: "",
    country: "",
    placeId: "",
    location: Location(
      x: 0,
      y: 0,
    ),
    completeAddress: "",
  ).obs;
  var to = PlaceDetails(
    home: "",
    street: "",
    city: "",
    district: "",
    province: "",
    country: "",
    placeId: "",
    location: Location(
      x: 0,
      y: 0,
    ),
    completeAddress: "",
  ).obs;

  var end = PlaceDetails(
    home: "",
    street: "",
    city: "",
    district: "",
    province: "",
    country: "",
    placeId: "",
    location: Location(
      x: 0,
      y: 0,
    ),
    completeAddress: "",
  ).obs;

  void clearData() {
    start.value = PlaceDetails(
      home: "",
      street: "",
      city: "",
      district: "",
      province: "",
      country: "",
      placeId: "",
      location: Location(
        x: 0,
        y: 0,
      ),
      completeAddress: "",
    );
    to.value = PlaceDetails(
      home: "",
      street: "",
      city: "",
      district: "",
      province: "",
      country: "",
      placeId: "",
      location: Location(
        x: 0,
        y: 0,
      ),
      completeAddress: "",
    );
    end.value = PlaceDetails(
      home: "",
      street: "",
      city: "",
      district: "",
      province: "",
      country: "",
      placeId: "",
      location: Location(
        x: 0,
        y: 0,
      ),
      completeAddress: "",
    );
    polyLineCoordinates.value.clear();
    polyLineSet.value.clear();
    markersSet.value.clear();
    circlesSet.value.clear();
  }

  Future<PlaceDetails> searchCoordinateAddress(Location location) async {
    String placeAddress = "";
    String url =
        "/maps/api/geocode/json?latlng=${location.x},${location.y}&key=${Google_MAP_API_KEY}";

    var response = await externalAPIGetRequest(url: url);
    PlaceDetails placeDetails = PlaceDetails(
      home: "",
      street: "",
      city: "",
      district: "",
      province: "",
      country: "",
      placeId: "",
      location: Location(
        x: 0,
        y: 0,
      ),
      completeAddress: "",
    );

    if (response != "error") {
      debugPrint(
          "sdvds: " + response["results"][0]["formatted_address"].toString());
      // st1 = response["results"][0]["address_components"][1]["long_name"];
      // st2 = response["results"][0]["address_components"][2]["long_name"];
      placeDetails.home =
          response["results"][0]["address_components"][0]["long_name"];
      debugPrint(placeDetails.home);
      placeDetails.street =
          response["results"][0]["address_components"][1]["long_name"];
      debugPrint(placeDetails.street);
      placeDetails.city =
          response["results"][0]["address_components"][2]["long_name"];
      debugPrint(placeDetails.city);
      placeDetails.district =
          response["results"][0]["address_components"][3]["long_name"];
      debugPrint(placeDetails.district);
      debugPrint("why ");
      placeDetails.completeAddress =
          response["results"][0]["formatted_address"];
      debugPrint(placeDetails.completeAddress);
      placeDetails.placeId = response["results"][0]["place_id"];
      debugPrint(placeDetails.placeId);
      placeDetails.location = location;
    }
    return placeDetails;
  }

  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    String url =
        "/maps/api/place/details/json?place_id=$placeId&key=$Google_MAP_API_KEY";

    var response = await externalAPIGetRequest(url: url);
    Location location = Location(
      x: 0,
      y: 0,
    );
    debugPrint("response: " + response.toString());
    if (response != "error") {
      if (response["status"] == "OK") {
        location = Location(
          x: response["result"]["geometry"]["location"]["lat"],
          y: response["result"]["geometry"]["location"]["lng"],
        );
        return {"state": true, "location": location};
      } else {
        Get.snackbar("Something is wrong" + "!!!", "Please try again");
        return {"state": false, "location": location};
      }
    } else {
      return {"state": false, "location": location};
    }
  }

  Future<bool> getStartPlaceDetails(String placeId) async {
    var result = await getPlaceDetails(placeId);
    if (!result["state"]) {
      return false;
    } else {
      Location location = result["location"];
      start.value.location = location;
      return true;
    }
  }

  Future<bool> getEndPlaceDetails(String placeId) async {
    var result = await getPlaceDetails(placeId);
    if (!result["state"]) {
      return false;
    } else {
      Location location = result["location"];
      to.value.location = location;
      return true;
    }
  }

  Future<Map<String, dynamic>> getDirectionDetails(
      Location startLocation, Location endLocation) async {
    String url =
        "/maps/api/directions/json?destination=${endLocation.x},${endLocation.y}&origin=${startLocation.x},${startLocation.y}&key=$Google_MAP_API_KEY";

    var response = await externalAPIGetRequest(url: url);
    DirectionDetails directionDetailsLocal = DirectionDetails(
      distanceText: "0",
      durationText: "0",
      encodedPoints: "",
      distanceValue: 0,
      durationValue: 0,
    );
    debugPrint("response: " + response.toString());
    if (response != "error") {
      if (response["status"] == "OK") {
        directionDetailsLocal.encodedPoints =
            response["routes"][0]["overview_polyline"]["points"];
        directionDetailsLocal.distanceText =
            response["routes"][0]["legs"][0]["distance"]["text"];
        directionDetailsLocal.distanceValue =
            response["routes"][0]["legs"][0]["distance"]["value"];
        directionDetailsLocal.durationText =
            response["routes"][0]["legs"][0]["duration"]["text"];
        directionDetailsLocal.durationValue =
            response["routes"][0]["legs"][0]["duration"]["value"];
        directionDetails.value = directionDetailsLocal;
        return {"state": true, "directionDetails": directionDetailsLocal};
      } else {
        Get.snackbar("Something is wrong" + "!!!", "Please try again");
        return {"state": false, "directionDetails": directionDetailsLocal};
      }
    } else {
      return {"state": false, "directionDetails": directionDetailsLocal};
    }
  }

  void setPolyLines() async {
    polyLineLoading.value = true;

    polyLineCoordinates.value.clear();
    polyLineSet.value.clear();
    markersSet.value.clear();
    circlesSet.value.clear();
    debugPrint("SDgdsgzdsgg gd fbg fs ");
    debugPrint(directionDetails.value.toJson().toString());
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResult =
        polylinePoints.decodePolyline(directionDetails.value.encodedPoints);
    if (decodePolyLinePointsResult.isNotEmpty) {
      decodePolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        polyLineCoordinates.value.add(LatLng(
          pointLatLng.latitude,
          pointLatLng.longitude,
        ));
      });
    }

    Polyline polyline = Polyline(
      color: Colors.pink,
      polylineId: PolylineId("PolyLineID"),
      jointType: JointType.round,
      points: polyLineCoordinates,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );
    polyLineSet.value.add(polyline);

    LatLngBounds latLngBounds;
    LatLng pickupLatLng =
        LatLng(start.value.location.x, start.value.location.y);
    LatLng dropOffLatLng = LatLng(to.value.location.x, to.value.location.y);
    if (pickupLatLng.latitude > dropOffLatLng.latitude &&
        pickupLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickupLatLng);
    } else if (pickupLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickupLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickupLatLng.longitude));
    } else if (pickupLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickupLatLng.longitude),
          northeast: LatLng(pickupLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickupLatLng, northeast: dropOffLatLng);
    }
    Completer<GoogleMapController> _controllerGoogleMap = Completer();

    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(
          title: start.value.getLocationText(), snippet: "My Location"),
      position: pickupLatLng,
      markerId: MarkerId("pickUpID"),
    );

    Marker dropOffLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(
          title: to.value.getLocationText(), snippet: "DropOff Location"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffID"),
    );

    markersSet.value.add(pickUpLocationMarker);
    markersSet.value.add(dropOffLocationMarker);

    Circle pickUpCircle = Circle(
      fillColor: Colors.blue,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpID"),
    );
    Circle dropOffCircle = Circle(
      fillColor: Colors.yellow,
      center: pickupLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.yellowAccent,
      circleId: CircleId("dropOffID"),
    );
    circlesSet.value.add(pickUpCircle);
    circlesSet.value.add(dropOffCircle);
    polyLineCoordinates.refresh();
    polyLineSet.refresh();
    markersSet.refresh();
    circlesSet.refresh();
    polyLineLoading.value = false;
  }

  Future<void> locatePosition() async {
    polyLineCoordinates.value.clear();
    polyLineSet.value.clear();
    markersSet.value.clear();
    circlesSet.value.clear();
    polyLineCoordinates.refresh();
    polyLineSet.refresh();
    markersSet.refresh();
    circlesSet.refresh();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLastPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLastPosition, zoom: 14);

    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
