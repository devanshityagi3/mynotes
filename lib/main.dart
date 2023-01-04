import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() async {
  //an asynchronous operation allows other operations to execute before it completes.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        newNoteRoute: (context) => const newNoteView(), 
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //build context is a bit of info about the context where your widget is at
    return FutureBuilder(
      //we told FutureBuilder to perform a future that is firebase initializeApp
      future: AuthService.firebase().initialize(),
      //in future we are telling that we are waiting for firebase initialize app to do its work

      builder: (context, snapshot) {
        /*snapshot of an object is the state of an object.
        snapshot is your way of getting the results of your future. Has it started? Is it processing? Is it done or did it fail. */

        switch (snapshot.connectionState) {
          //tells the state

          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView(); //we are putting this verifyEmailView widget that is returned
                //   //from the build function inside this current screen's content.
              }
            } else {
              return const LoginView();
            }

          //Firebase initialize app done -- if the connection is done return this step
          default:
            return const CircularProgressIndicator(); //otherwise return this step
        }
      },
    );
  }
}
