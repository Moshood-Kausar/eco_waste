// To parse this JSON data, do
//
//     final placeIdModel = placeIdModelFromJson(jsonString);

import 'dart:convert';

PlaceIdModel placeIdModelFromJson(String str) => PlaceIdModel.fromJson(json.decode(str));

String placeIdModelToJson(PlaceIdModel data) => json.encode(data.toJson());

class PlaceIdModel {
    PlaceIdModel({
         this.htmlAttributions,
        this.result,
        this.status,
    });

    List<dynamic>? htmlAttributions;
    Result? result;
    String? status;

    factory PlaceIdModel.fromJson(Map<String, dynamic> json) => PlaceIdModel(
        htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: Result.fromJson(json["result"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "result": result!.toJson(),
        "status": status,
    };
}

class Result {
    Result({
        required this.addressComponents,
        required this.adrAddress,
        required this.businessStatus,
        required this.currentOpeningHours,
        required this.formattedAddress,
        required this.formattedPhoneNumber,
        required this.geometry,
        required this.icon,
        required this.iconBackgroundColor,
        required this.iconMaskBaseUri,
        required this.internationalPhoneNumber,
        required this.name,
        required this.openingHours,
        required this.placeId,
        required this.plusCode,
        required this.reference,
        required this.types,
        required this.url,
        required this.utcOffset,
        required this.vicinity,
    });

    List<AddressComponent> addressComponents;
    String adrAddress;
    String businessStatus;
    CurrentOpeningHours currentOpeningHours;
    String formattedAddress;
    String formattedPhoneNumber;
    Geometry geometry;
    String icon;
    String iconBackgroundColor;
    String iconMaskBaseUri;
    String internationalPhoneNumber;
    String name;
    OpeningHours openingHours;
    String placeId;
    PlusCode plusCode;
    String reference;
    List<String> types;
    String url;
    int utcOffset;
    String vicinity;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"],
        businessStatus: json["business_status"],
        currentOpeningHours: CurrentOpeningHours.fromJson(json["current_opening_hours"]),
        formattedAddress: json["formatted_address"],
        formattedPhoneNumber: json["formatted_phone_number"],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        internationalPhoneNumber: json["international_phone_number"],
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        placeId: json["place_id"],
        plusCode: PlusCode.fromJson(json["plus_code"]),
        reference: json["reference"],
        types: List<String>.from(json["types"].map((x) => x)),
        url: json["url"],
        utcOffset: json["utc_offset"],
        vicinity: json["vicinity"],
    );

    Map<String, dynamic> toJson() => {
        "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "adr_address": adrAddress,
        "business_status": businessStatus,
        "current_opening_hours": currentOpeningHours.toJson(),
        "formatted_address": formattedAddress,
        "formatted_phone_number": formattedPhoneNumber,
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "international_phone_number": internationalPhoneNumber,
        "name": name,
        "opening_hours": openingHours.toJson(),
        "place_id": placeId,
        "plus_code": plusCode.toJson(),
        "reference": reference,
        "types": List<dynamic>.from(types.map((x) => x)),
        "url": url,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
    };
}

class AddressComponent {
    AddressComponent({
        required this.longName,
        required this.shortName,
        required this.types,
    });

    String longName;
    String shortName;
    List<String> types;

    factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
    };
}

class CurrentOpeningHours {
    CurrentOpeningHours({
        required this.openNow,
        required this.periods,
        required this.weekdayText,
    });

    bool openNow;
    List<CurrentOpeningHoursPeriod> periods;
    List<String> weekdayText;

    factory CurrentOpeningHours.fromJson(Map<String, dynamic> json) => CurrentOpeningHours(
        openNow: json["open_now"],
        periods: List<CurrentOpeningHoursPeriod>.from(json["periods"].map((x) => CurrentOpeningHoursPeriod.fromJson(x))),
        weekdayText: List<String>.from(json["weekday_text"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
    };
}

class CurrentOpeningHoursPeriod {
    CurrentOpeningHoursPeriod({
        required this.close,
        required this.open,
    });

    PurpleClose close;
    PurpleClose open;

    factory CurrentOpeningHoursPeriod.fromJson(Map<String, dynamic> json) => CurrentOpeningHoursPeriod(
        close: PurpleClose.fromJson(json["close"]),
        open: PurpleClose.fromJson(json["open"]),
    );

    Map<String, dynamic> toJson() => {
        "close": close.toJson(),
        "open": open.toJson(),
    };
}

class PurpleClose {
    PurpleClose({
        required this.date,
        required this.day,
        required this.time,
    });

    DateTime date;
    int day;
    String time;

    factory PurpleClose.fromJson(Map<String, dynamic> json) => PurpleClose(
        date: DateTime.parse(json["date"]),
        day: json["day"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "day": day,
        "time": time,
    };
}

class Geometry {
    Geometry({
        required this.location,
        required this.viewport,
    });

    Location location;
    Viewport viewport;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
    };
}

class Location {
    Location({
        required this.lat,
        required this.lng,
    });

    double lat;
    double lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

class Viewport {
    Viewport({
        required this.northeast,
        required this.southwest,
    });

    Location northeast;
    Location southwest;

    factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
    );

    Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
    };
}

class OpeningHours {
    OpeningHours({
        required this.openNow,
        required this.periods,
        required this.weekdayText,
    });

    bool openNow;
    List<OpeningHoursPeriod> periods;
    List<String> weekdayText;

    factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
        periods: List<OpeningHoursPeriod>.from(json["periods"].map((x) => OpeningHoursPeriod.fromJson(x))),
        weekdayText: List<String>.from(json["weekday_text"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
    };
}

class OpeningHoursPeriod {
    OpeningHoursPeriod({
        required this.close,
        required this.open,
    });

    FluffyClose close;
    FluffyClose open;

    factory OpeningHoursPeriod.fromJson(Map<String, dynamic> json) => OpeningHoursPeriod(
        close: FluffyClose.fromJson(json["close"]),
        open: FluffyClose.fromJson(json["open"]),
    );

    Map<String, dynamic> toJson() => {
        "close": close.toJson(),
        "open": open.toJson(),
    };
}

class FluffyClose {
    FluffyClose({
        required this.day,
        required this.time,
    });

    int day;
    String time;

    factory FluffyClose.fromJson(Map<String, dynamic> json) => FluffyClose(
        day: json["day"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
    };
}

class PlusCode {
    PlusCode({
        required this.compoundCode,
        required this.globalCode,
    });

    String compoundCode;
    String globalCode;

    factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
    );

    Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
    };
}
