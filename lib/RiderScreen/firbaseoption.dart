import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }




  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8ooP8-NtFnSUJveAA_Rc9SKrAuCUx4MI',
    appId: '1:1094098736042:android:cdd1f9ab6533a707b491d3',
    messagingSenderId: '1094098736042',
    projectId: 'instantdriver-4c5c7',
    storageBucket: 'instantdriver-4c5c7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key',
    appId: 'your-ios-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-storage-bucket',
    iosBundleId: 'your-ios-bundle-id',
  );

}



