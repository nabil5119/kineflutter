import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Cloud Function"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            String username = 'test.kine5119@gmail.com';
            String password = 'test@5119';
            String destination = 'nabil.zaghloul191@gmail.com';
            final smtpServer = gmail(username, password);
            // String domainSmtp = 'mail.domain.com';

            //also use for gmail smtp
            //final smtpServer = gmail(username, password);

            //user for your own domain
            //final smtpServer =
            //  SmtpServer(domainSmtp, username: username, password: password, port: 587);

            final message = Message()
              ..from = Address(username, 'Nabil')
              ..recipients.add(Address(destination))
              //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
              //..bccRecipients.add(Address('bccAddress@example.com'))
              ..subject = 'Your credentiels :: 😀 :: ${DateTime.now()}'
              ..text = 'here is your credentials!!'
              ..html =
                  "<h1>Kinetherapie</h1>\n<p>Hey! Here's some HTML content</p>";

            try {
              final sendReport = await send(message, smtpServer);
              print('Message sent: ' + sendReport.toString());
            } on MailerException catch (e) {
              print('Message not sent.');
              for (var p in e.problems) {
                print('Problem: ${p.code}: ${p.msg}');
              }
            }
          },
          child: Text('Send Mail'),
        ),
      ),
    );
  }
}
