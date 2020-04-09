import 'package:flutter_styra/shared/util-map.dart';

class MagicScheduleModel {
  bool autoOff;
  bool autoOn;
  String disableFrom;
  String enableFrom;
  bool ignoreGPIO;
  String name;
  int updateCycle;

  MagicScheduleModel({
    this.autoOff,
    this.autoOn,
    this.disableFrom,
    this.enableFrom,
    this.ignoreGPIO,
    this.name,
    this.updateCycle,
  });

  static MagicScheduleModel fromMap({Map<String, dynamic> map}) {
    return MagicScheduleModel(
      autoOff: getKey(map: map, key: "auto_off", defaultVal: false),
      autoOn: getKey(map: map, key: "auto_on", defaultVal: false),
      disableFrom: getKey(map: map, key: "disable_from", defaultVal: "00:00:00"),
      enableFrom: getKey(map: map, key: "enable_from", defaultVal: "00:00:00"),
      ignoreGPIO: getKey(map: map, key: "ignore_gpio", defaultVal: false),
      name: getKey(map: map, key: "name", defaultVal: "none"),
      updateCycle: getKey(map: map, key: "update_cycle", defaultVal: 60),
    );
  }

  static MagicScheduleModel empty() {
    return MagicScheduleModel.fromMap(map: {});
  }

  Map<String, dynamic> toMap() {
    return {
      'auto_off': autoOff,
      'auto_on': autoOn,
      'disable_from': disableFrom,
      'enable_from': enableFrom,
      'ignore_gpio': ignoreGPIO,
      'name': name,
      'update_cycle': updateCycle,
    };
  }
}
