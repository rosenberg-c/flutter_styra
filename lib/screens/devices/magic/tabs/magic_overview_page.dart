import 'package:flutter/material.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/services/http/requests/utils/get-online.dart';
import 'package:flutter_styra/services/http/requests/utils/get-temp.dart';
import 'package:flutter_styra/services/http/requests/utils/get-uptime.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/connection_status.dart';
import 'package:provider/provider.dart';

class MagicOverviewPage extends StatefulWidget {
  final DeviceModel device;

  MagicOverviewPage({@required this.device});

  @override
  _MagicOverviewPageState createState() => _MagicOverviewPageState();
}

class _MagicOverviewPageState extends State<MagicOverviewPage> {
  String _uptime;
  String _temp;
  Widget _status_widget;

  _syncWithDevice() async {
    final __uptime = await getUptime(widget.device);
    final __temp = await getTemp(widget.device);
    setState(() {
      _uptime = __uptime;
      _temp = __temp;
    });
  }

  @override
  void initState() {
    getOnline(widget.device).then((val) {
      setState(() {
        _status_widget = status_box(val);
      });
      _syncWithDevice();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);

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
                    await _syncWithDevice();
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
                Card(
                  color: theme.pColor[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Host"),
                          trailing: Text(widget.device.host),
                        ),
                        ListTile(
                          title: Text("Uptime"),
                          trailing: Text(_uptime.toString()),
                        ),
                        ListTile(
                          title: Text("Temp"),
                          trailing: Text(_temp.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: <Widget>[
//                    FlatButton(
//                      child: Text("Fetch"),
//                      onPressed: () async {
//                        setState(() {
//                          _status_widget = status_box(false);
//                        });
//                        await _syncWithDevice();
//                        setState(() {
//                          _status_widget = status_box(true);
//                        });
//                      },
//                    ),
//                  ],
//                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
