import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/stores/location_store.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationStore locationStore = LocationStore();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    locationStore.getLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locationStore.getLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {

          },
          child: Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: CustomIcon(
              icon: "current_location",
              width: 19,
            )
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "Localizações",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 15),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Observer(
          builder: (_) {
            return locationStore.locationListBuilder.isNotEmpty
                ? ListView(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        child: Container(
                          height: 34,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFE5E5E4)),
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              icon: Container(
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                                child: CustomIcon(
                                  icon: "search_bold",
                                  width: 13,
                                  height: 13,
                                ),
                              ),
                              hintText: "Pesquisar",
                              hintStyle: TextStyle(color: Color(0xFF777777)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 11)
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, [
                            locationStore.locationListBuilder[0].locality,
                            (locationStore.locationListBuilder[0].country +
                                ", " +
                                locationStore
                                    .locationListBuilder[0].isoCountryCode)
                          ]);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0].locality,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0].country +
                                      ", " +
                                      locationStore.locationListBuilder[0]
                                          .isoCountryCode,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, [
                            locationStore
                                .locationListBuilder[0].administrativeArea,
                            (locationStore.locationListBuilder[0].country +
                                ", " +
                                locationStore
                                    .locationListBuilder[0].isoCountryCode)
                          ]);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0]
                                      .administrativeArea,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0].country +
                                      ", " +
                                      locationStore.locationListBuilder[0]
                                          .isoCountryCode,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, [
                            locationStore.locationListBuilder[0].locality,
                            (locationStore
                                    .locationListBuilder[0].administrativeArea +
                                ", " +
                                locationStore.locationListBuilder[0].country +
                                ", " +
                                locationStore
                                    .locationListBuilder[0].isoCountryCode)
                          ]);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0].locality,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0]
                                          .administrativeArea +
                                      ", " +
                                      locationStore
                                          .locationListBuilder[0].country +
                                      ", " +
                                      locationStore.locationListBuilder[0]
                                          .isoCountryCode,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, [
                            locationStore.locationListBuilder[0].country,
                            (locationStore.locationListBuilder[0].country +
                                ", " +
                                locationStore
                                    .locationListBuilder[0].isoCountryCode)
                          ]);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0].country,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0].country +
                                      ", " +
                                      locationStore.locationListBuilder[0]
                                          .isoCountryCode,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, [
                            locationStore
                                .locationListBuilder[0].subAdministrativeArea,
                            locationStore
                                .locationListBuilder[0].administrativeArea
                          ]);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0]
                                      .subAdministrativeArea,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  locationStore.locationListBuilder[0]
                                      .administrativeArea,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
