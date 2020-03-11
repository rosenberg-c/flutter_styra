import 'package:flutter_styra/models/backlight/backlight.dart';
import 'package:flutter_styra/models/device/device_mirror_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-backlight.dart';

Future getBacklightConfig(DeviceMirrorModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      BacklightEndpoint.getConfig,
    );

    return BacklightConfigModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${getBacklightConfig}');
  }
  print("Return Empty ${getBacklightConfig}");
  return BacklightConfigModel.empty();
}
