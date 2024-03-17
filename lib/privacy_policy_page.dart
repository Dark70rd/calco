import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: <TextSpan>[
                TextSpan(
                    text: 'Privacy Policy\n\n',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'This privacy policy applies to the Calco app'
                        '(hereby referred to as "Application") for mobile devices'
                        'that was created by Dark70rd (hereby referred to as "Service Provider")'
                        'as an Open Source service.'
                        'This service is intended for use "AS IS".\n\n',
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                    text:
                        'What information does the Application obtain and how is it used?\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'The Application does not obtain'
                        'any information when you download and use it.'
                        'Registration is not required to use the Application.\n\n',
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                    text:
                        'Does the Application collect precise real time location information of the device?\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        'This Application does not collect precise information about the location of your mobile device.\n\n',
                    style: TextStyle(fontSize: 16)),
                // Continue with the rest of your privacy policy text
                TextSpan(
                    text:
                        'Do third parties see and/or have access to information obtained by the Application?\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        'Since the Application does not collect any information, no data is shared with third parties.\n\n',
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                    text: 'What are my opt-out rights?\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'You can stop all collection of information'
                        'by the Application easily by uninstalling it.'
                        'You may use the standard uninstall processes as'
                        'may be available as part of your mobile device or'
                        'via the mobile application marketplace or network.\n\n',
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                    text: 'Children\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'The Application is not used to knowingly'
                        'solicit data from or market to children'
                        'under the age of 13. The Service Provider'
                        'does not knowingly collect personally identifiable'
                        'information from children. The Service Provider'
                        'encourages all children to never submit any personally'
                        'identifiable information through the Application and/or'
                        'Services. The Service Provider encourage parents and legal'
                        'guardians to monitor their children\'s Internet usage and to'
                        'help enforce this Policy by instructing their children never'
                        'to provide personally identifiable information through the'
                        'Application and/or Services without their permission. If you'
                        'have reason to believe that a child has provided personally'
                        'identifiable information to the Service Provider through the'
                        'Application and/or Services, please contact the Service Provider'
                        '(Calco@support.uk) so that they will be able to take the necessary'
                        'actions. You must also be at least 16 years of age to consent to'
                        'the processing of your personally identifiable information in'
                        'your country (in some countries we may allow your parent or'
                        'guardian to do so on your behalf).\n\n',
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                    text: 'Security\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        'The Service Provider is concerned about safeguarding the'
                        'confidentiality of your information. However, since the'
                        'Application does not collect any information, there is no'
                        'risk of your data being accessed by unauthorized individuals.\n\n',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                TextSpan(
                    text: 'Changes\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        'This Privacy Policy may be updated from time to time for any reason.'
                        'The Service Provider will notify you of any changes to their Privacy Policy'
                        'by updating this page with the new Privacy Policy. You are advised to consult'
                        'this Privacy Policy regularly for any changes, as continued use is deemed approval'
                        'of all changes.This privacy policy is effective as of 2024-03-1\n\n',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                TextSpan(
                    text: 'Your Consent\n\n',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        'By using the Application, you are consenting to the processing'
                        'of your information as set forth in this Privacy Policy now'
                        'and as amended by the Service Provider.\n\n',
                    style: TextStyle(
                      fontSize: 16,
                    )),

                TextSpan(
                    text: 'Contact Us\n\n',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        'If you have any questions regarding privacy while using the Application,'
                        'or have questions about the practices, please contact the'
                        'Service Provider via email at "Calco@support.uk".\n\n',
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                    text: 'This privacy policy page was generated by ',
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                  text: 'App Privacy Policy Generator',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrl(Uri.parse(
                          'https://app-privacy-policy-generator.nisrulz.com/'));
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
