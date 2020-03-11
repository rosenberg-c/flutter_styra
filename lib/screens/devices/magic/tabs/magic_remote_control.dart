import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/screens/webview/webview_screen.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/backlight_control/backlight-control-off.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/backlight_control/backlight-control-on.dart';
import 'package:flutter_styra/services/http/requests/general/device_control/device-control-reboot.dart';
import 'package:flutter_styra/services/http/requests/general/device_control/device-control-shutdown.dart';
import 'package:flutter_styra/services/http/requests/general/utils/get-online.dart';
import 'package:flutter_styra/shared/connection_status.dart';

class MagicRemoteControl extends StatefulWidget {
  final DeviceModel device;

  MagicRemoteControl({this.device});

  @override
  _MagicRemoteControlState createState() => _MagicRemoteControlState();
}

class _MagicRemoteControlState extends State<MagicRemoteControl> {
  Widget _status_widget;

  @override
  void initState() {
    getOnline(
      host: widget.device.host,
      port: widget.device.requestPort,
    ).then((val) {
      setState(() {
        _status_widget = status_box(val);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _status_widget = status_box(false);
                    });
                    await getOnline(
                      host: widget.device.host,
                      port: widget.device.requestPort,
                    );
                    setState(() {
                      _status_widget = status_box(true);
                    });
                  },
                  child: _status_widget == null
                      ? status_box(false)
                      : _status_widget,
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Backlight",
                  ),
                  trailing: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("On"),
                          onPressed: () => backlightOn(widget.device),
                        ),
                        RaisedButton(
                          child: Text("Off"),
                          onPressed: () => backlightOff(widget.device),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Control",
                  ),
                  trailing: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Poweroff"),
                          onPressed: () async {
                            await deviceShutdown(
                              host: widget.device.host,
                              port: widget.device.requestPort,
                            );
                          },
                        ),
                        RaisedButton(
                          child: Text("Reboot"),
                          onPressed: () async {
                            await deviceReboot(
                              host: widget.device.host,
                              port: widget.device.requestPort,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Webview",
                  ),
                  trailing: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
//                        RaisedButton(
//                          child: Text("https"),
//                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => WebViewScreen(
//                                  url: widget.device.https,
//                                ),
//                              ),
//                            );
//                          },
//                        ),
                        Container(),
                        RaisedButton(
                          child: Text("http"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                  url: widget.device.http,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
