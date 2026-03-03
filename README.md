# 📱 Firebase Auth - Complete Flutter Mobile App

A clean and professional **Mobile Application** built with Flutter and Firebase. This project demonstrates a robust Authentication Flow, including Smart Auto-Login, Password Recovery, and State Management.

> **Note:** Although this is a Mobile App, a live web preview is available for convenience.

## 🔗 Live Demo (Web Preview)
Experience the app interface directly in your browser:
[**Launch Live Preview**](https://my-flutter-login-app.vercel.app)

---

## ✨ Features & Functionalities

* **Smart Entry (Auto-Login):** Uses `StreamBuilder` to check the user's auth state. If already logged in, it skips the welcome/login screens and goes straight to the **Home Screen**.
* **Sign Up:** New users can create accounts which are securely stored in Firebase Auth.
* **Login & Security:** Secure login system with real-time error handling.
* **Forgot Password (Advanced):**
    * Verifies if the email exists in the database before sending a reset link.
    * Sends a professional **Password Reset Email** via Firebase.
    * User-friendly error messages if the email is not registered.
* **Home Dashboard:** A protected area with a **Sign Out** feature that instantly returns the user to the Welcome screen.
* **Responsive UI:** Clean, modern design with a focused user experience.

---

## 🛠️ Built With

* **Framework:** [Flutter](https://flutter.dev)
* **Backend:** [Firebase Authentication](https://firebase.google.com)
* **State Management:** [Provider](https://pub.dev/packages/provider)
* **Architecture:** Clean folder structure with constants and reusable styles.
* **Deployment:** Vercel (for Web Preview).
