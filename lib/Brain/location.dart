
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:theummah/Brain/db.dart';
class LocationService{
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
     // Fluttertoast.showToast(msg: 'Location permissions are denied');
      return Future.error('Location services are disabled.');

    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
       // Fluttertoast.showToast(msg: 'Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
     // Fluttertoast.showToast(msg: 'Location permissions are denied');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }

  static Future<Placemark> getAddressFromLatLong()async {
    final position = await determinePosition();
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placeMarks);
    Placemark place = placeMarks[0];
    //Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    DB().updateLocationSetting(currentLocation: place.administrativeArea.toString() + ',' + place.country.toString());

  return place;
  }



}
