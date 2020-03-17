import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/energenie/socket_control/config_energenie_control.dart';

energenieSocketOff(EnergenieDeviceModel device, int socket) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      EnergenieSocketURLs.socketOff,
      {"sleep": 5, "socket": socket},
    );

    return response;
  } catch (e) {
    print("Error in ${energenieSocketOff}");
    return false;
  }
}
