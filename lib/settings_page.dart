import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:simple_calculator/themes_page.dart';
import 'package:simple_calculator/app_version_page.dart';
import 'package:simple_calculator/privacy_policy_page.dart';
import 'package:simple_calculator/terms_page.dart';
import 'package:simple_calculator/license_page.dart' as mylicensePage;
import 'package:simple_calculator/contact_page.dart';
import 'package:simple_calculator/feedback_page.dart';
import 'package:simple_calculator/alert_dialoug.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    inAppReview.requestReview();
  }

  Future<void> requestReview() async {
    showDialogAlert(context, '   Review is not available.');
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
          title: const Text('Settings'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(right: 2, left: 2, bottom: 2),
                  scrollDirection: Axis.vertical,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.color_lens_outlined,
                      ),
                      title: Text('Customize Theme'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThemesPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.star_rate_outlined,
                      ),
                      title: Text('Rate app'),
                      onTap: () {
                        requestReview();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.share_outlined,
                      ),
                      title: Text('Share app'),
                      onTap: () {
                        Share.share(
                            'Hey! Check out this amazing calculator app: https://github.com/Dark70rd/calco');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                      ),
                      title: Text('Privacy policy'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.security_outlined,
                      ),
                      title: Text('Terms and conditions'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsPage(),
                          ),
                        );
                      },
                    ),
                    //ListTile(
                    //  leading: Icon(
                    //    Icons.cookie_outlined,
                    //    //color: Colors.white,
                    //  ),
                    //  title: Text('Cookies policy'),
                    //),
                    ListTile(
                      leading: Icon(
                        Icons.book_outlined,
                      ),
                      title: Text('licenses'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => mylicensePage.LicensePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.mail_outline_sharp,
                      ),
                      title: Text('Contact'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.feedback_outlined,
                      ),
                      title: Text('Feedback'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.system_update_alt_outlined,
                      ),
                      title: Text('App version'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppVersionPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline_rounded,
                      ),
                      title: Text('About'),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Calco',
                          applicationVersion: '1.0.0',
                          applicationIcon: Icon(Icons.calculate_outlined),
                          applicationLegalese:
                              '© 2021 Calco. All rights reserved.',
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                  'Calco is a simple calculator app that performs'
                                  'basic arithmetic operations.'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
