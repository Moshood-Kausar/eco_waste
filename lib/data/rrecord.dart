import 'dart:convert';

RRecord rRecordFromJson(String str) => RRecord.fromJson(json.decode(str));

String rRecordToJson(RRecord data) => json.encode(data.toJson());

class RRecord {
  RRecord({
    required this.noPlastic,
    required this.noElectronics,
    required this.noGlass,
    required this.noCardboard,
  });

  int noPlastic;
  int noElectronics;
  int noGlass;
  int noCardboard;

  factory RRecord.fromJson(Map<String, dynamic> json) => RRecord(
        noPlastic: json["noPlastic"],
        noElectronics: json["noElectronics"],
        noGlass: json["noGlass"],
        noCardboard: json["noCardboard"],
      );

  Map<String, dynamic> toJson() => {
        "noPlastic": noPlastic,
        "noElectronics": noElectronics,
        "noGlass": noGlass,
        "noCardboard": noCardboard,
      };
}
