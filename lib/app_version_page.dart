import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

class AppVersionPage extends StatefulWidget {
  const AppVersionPage({Key? key}) : super(key: key);

  @override
  _AppVersionPageState createState() => _AppVersionPageState();
}

class _AppVersionPageState extends State<AppVersionPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('App Version'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(right: 2, left: 2, bottom: 2),
                    scrollDirection: Axis.vertical,
                    children: [
                      _infoTile('App Name', _packageInfo.appName),
                      _infoTile('Package Name', _packageInfo.packageName),
                      _infoTile('Version', _packageInfo.version),
                      _infoTile('Build Number', _packageInfo.buildNumber),
                      _infoTile('Build Signature', _packageInfo.buildSignature),
                      _infoTile('Installer Store',
                          _packageInfo.installerStore ?? 'not available'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
