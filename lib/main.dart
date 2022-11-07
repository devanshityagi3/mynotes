import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
void main() async {
  //an asynchronous operation allows other operations to execute before it completes.
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
  ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text('Home'),
     ),
     body: FutureBuilder( //we told FutureBuilder to perform a future that is firebase initializeApp  
      future: Firebase.initializeApp(  //in future we are telling that we are waiting for firebase initialize app to do its work
   options: DefaultFirebaseOptions.currentPlatform,),
      builder: (context, snapshot){  /*snapshot of an object is the state of an object.
        snapshot is your way of getting the results of your future. Has it started? Is it processing? Is it done or did it fail. */ 
        
        switch (snapshot.connectionState){ //tells the state
          
          case ConnectionState.done:
          final user = FirebaseAuth.instance.currentUser;
          
          if(user?.emailVerified ?? false){
            print('You are a verified user');
          }
          else{
            print('You need to verify your email first');
          }
           return const Text('Done'); //Firebase initialize app done
       default:
          return const Text('Loading...');
        }
        
        
      },
       
     ),
    );
  }
}

