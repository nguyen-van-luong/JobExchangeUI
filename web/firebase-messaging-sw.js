// Import the Firebase Messaging module
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

// Initialize Firebase
firebase.initializeApp({
  apiKey: "AIzaSyBf45u9mHKgh9AgVvubzQAEO2cyB0cYT28",
    authDomain: "demofirebase-f428c.firebaseapp.com",
    projectId: "demofirebase-f428c",
    storageBucket: "demofirebase-f428c.appspot.com",
    messagingSenderId: "951099900733",
    appId: "1:951099900733:web:a3330292e1af33a4a8bb54"
});

// Retrieve an instance of Firebase Messaging
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
