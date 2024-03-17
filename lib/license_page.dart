import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LicensePage extends StatefulWidget {
  @override
  _LicensePageState createState() => _LicensePageState();
}

class _LicensePageState extends State<LicensePage> {
  List<LicenseEntry> _licenses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLicenses();
  }

  void _getLicenses() async {
    final licenseStream = await LicenseRegistry.licenses;
    licenseStream.toList().then((licenses) {
      setState(() {
        _licenses = licenses;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Licenses'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'MIT License\n\n',
                          ),
                          TextSpan(
                            text: 'Copyright (c) 2024 D42X702D\n\n'
                                'Permission is hereby granted, free of charge, to any person obtaining a copy'
                                'of this software and associated documentation files (the "Software"), to deal'
                                'in the Software without restriction, including without limitation the rights'
                                'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell'
                                'copies of the Software, and to permit persons to whom the Software is'
                                'furnished to do so, subject to the following conditions:'
                                'The above copyright notice and this permission notice shall be included in all  '
                                'copies or substantial portions of the Software.'
                                'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR'
                                'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,'
                                'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE'
                                'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER'
                                'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,'
                                'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE'
                                'SOFTWARE.\n\n',
                          ),
                          //TextSpan(
                          //  text: 'Google Play Services\n\n',
                          //  style: TextStyle(
                          //    color: Colors.blue,
                          //    decoration: TextDecoration.underline,
                          //  ),
                          //  // Add onTap callback to open the link
                          //  recognizer: TapGestureRecognizer()
                          //    ..onTap = () {
                          //      // Open the link
                          //    },
                          //),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: _licenses.expand((license) {
                        return [
                          Text(
                            license.packages.join(', '),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          for (var paragraph in license.paragraphs)
                            Text(paragraph.text),
                          SizedBox(height: 16),
                        ];
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
