import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
 
 late final TextEditingController _email; /*late means although abhi koi value nhi di h maine 
  lekin aage jaake main promise karti hu ki main dedungi. */
  late final TextEditingController _password;
    
  @override
  void initState(){
    _email =TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
 
@override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: const Text('Register'),
     ),
     body: FutureBuilder( //we told FutureBuilder to perform a future that is firebase initializeApp  
      future: Firebase.initializeApp(  //in future we are telling that we are waiting for firebase initialize app to do its work
   options: DefaultFirebaseOptions.currentPlatform,),
      builder: (context, snapshot){  /*snapshot of an object is the state of an object.
        snapshot is your way of getting the results of your future. Has it started? Is it processing? Is it done or did it fail. */ 
        
        switch (snapshot.connectionState){
          
          case ConnectionState.done:
           return Column(
         children: [
          TextField(
            controller: _email, //proxy object iski help se
            // textfield k ander jo text h vo textbutton k sath jud jayega 
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter email here',
               ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter password here'
            ),
          ),
           TextButton(
            onPressed: () async {

              final email = _email.text; /*proxy object is connected to textfield
              now to connect textbutton to it we have done this. */   
              final password = _password.text;
              try{

     
              final userCredential =
               await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
                );
                print(userCredential);
                } on FirebaseAuthException catch(e){
                  if(e.code == 'weak password'){
                    print('Weak password');
                  } else if(e.code == 'email-already-in-use'){
                    print('Email is already in use');
                  }
                  else if(e.code =='invalid-email') {
                    print('Invalid Email');
                  }
                }
            },
           child: const Text('Register'),
            ),
         ],
       );
       default:
          return const Text('Loading...');
        }
        
        
      },
       
     ),
    );
  }
}

