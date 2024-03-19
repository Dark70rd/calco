import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class LicensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Licenses'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              RichText(
                  text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: 'This project is licensed under the ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'GPL V3.0 license.\n\n',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(
                            'https://github.com/Dark70rd/calco/blob/master/LICENSE'));
                      },
                  ),
                  TextSpan(
                    text: 'Copyright © 2023 Dark70rd\n\n',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Calco is a free software licensed under GPL v3.0.'
                        ' It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY'
                        ' without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n\n',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                    text:
                        'Being Open Source doesn\'t mean you can just make a copy of the app and upload it on playstore or sell'
                        ' a closed source copy of the same.\n\n'
                        'Read the following carefully:\n\n'
                        '1. Any copy of a software under GPL must be under same license. So you can\'t upload the app on a closed source'
                        'app repository like PlayStore/AppStore without distributing the source code.\n\n'
                        '2. You can\'t sell any copied/modified version of the app under any \"non-free\" license.\n\n'
                        'You must provide the copy with the original software or with instructions on how to obtain original software\,'
                        ' should clearly state all changes, should clearly disclose full source code, should include same license'
                        'and all copyrights should be retained.\n\n',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                    text:
                        'In simple words, You can ONLY use the source code of this app for `Open Source` Project under `GPL v3.0` or later'
                        ' with all your source code CLEARLY DISCLOSED on any code hosting platform like GitHub, with clear INSTRUCTIONS on'
                        ' how to obtain the original software, should clearly STATE ALL CHANGES made and should RETAIN all copyrights.\n\n'
                        'Use of this software under any "non-free" license is NOT permitted.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          'https://github.com/Dark70rd/calco/blob/master/LICENSE'));
                    },
                    child: Text('Show Full License')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  child: Text(
                    'Show Additional Licenses',
                  ),
                  onPressed: () {
                    showLicensePage(
                      context: context,
                      applicationName: 'Calco',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2021 Flutter Community',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
