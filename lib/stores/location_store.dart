import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

part 'location_store.g.dart';

class LocationStore = _LocationStore with _$LocationStore;

abstract class _LocationStore with Store {
  var _location = Location();

  List<Placemark> locationList;

  @observable
  double latitude = -23.549161;

  @observable
  double longitude = -46.635968;

  ObservableList<Placemark> locationListBuilder = ObservableList<Placemark>();

  @action
  Future<void> getLocation() async {
    _location.onLocationChanged.listen(
      (LocationData currentLocation) async {
        latitude =
            currentLocation != null ? currentLocation.latitude : -23.549161;
        longitude =
            currentLocation != null ? currentLocation.longitude : -46.635968;

        locationList =
            await Geolocator().placemarkFromCoordinates(latitude, longitude);
      locationListBuilder.add(locationList[0]);
        },
    );
  }
}
