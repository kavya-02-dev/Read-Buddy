
# 📚 Read Buddy

## 📋 Description

**Read Buddy** is a Flutter-based mobile application that helps book lovers **discover, explore, and search books across multiple genres**.
It integrates the **Google Books API** to fetch live book data and uses **Firebase Authentication** for secure user sign-up and login.

The app features a **modern gradient-based UI**, **genre-wise browsing**, and **real-time search**, delivering a smooth and intuitive reading discovery experience.

---

## ✨ Features

* 🔐 **Secure Authentication** using Firebase (Email & Password)
* 📖 **Explore Books by Genre** powered by Google Books API
* 🔍 **Real-time Book Search** by title
* 🧑‍💼 **User Profile Page** with account details
* 📚 **Scrollable, genre-wise layout** for improved UX
* 🎨 **Modern gradient UI** with animated splash screen

---

## 🧰 Technology Stack

* **Flutter** – Cross-platform mobile app framework
* **Dart** – Programming language
* **Firebase Authentication** – User login and signup
* **Google Books API** – Real-time book data
* **HTTP** – Network requests
* **Material Design** – Clean and consistent UI

---

## 🚀 Getting Started

### ✅ Prerequisites

* Flutter SDK **3.x.x**
* Dart SDK
* Firebase project configured
* Google Books API (no key required for basic queries)

---

### 📦 1. Clone the Repository

```bash
git clone https://github.com/your-username/readbuddy.git
cd readbuddy
```

---

### 📱 2. Install Dependencies

```bash
flutter pub get
```

---

### 🔥 3. Configure Firebase

* `firebase_options.dart` is already generated using **FlutterFire CLI**
* Enable **Email/Password Authentication** in Firebase Console

---

### ▶️ 4. Run the Application

```bash
flutter run
```

---

## 🧪 Screenshots

<p align="center">
  <img width="352" height="740" alt="f1" src="https://github.com/user-attachments/assets/a3830692-b682-4417-b4f9-077c6a268078" />
  <img width="347" height="707" alt="f2" src="https://github.com/user-attachments/assets/695f80dc-2189-4ef8-9c4c-58e9dca56cd8" />
  <img width="350" height="737" alt="f3" src="https://github.com/user-attachments/assets/2a3682cd-e89a-4a87-bf8a-3bc7cd40e80b" />
  <img width="352" height="756" alt="f4" src="https://github.com/user-attachments/assets/83ea72ed-712f-487b-86fe-509d2db28a66" />
  <img width="336" height="147" alt="f5" src="https://github.com/user-attachments/assets/c366c8f2-de0d-4056-87fd-1e9bffe1af1b" />
  <img width="338" height="152" alt="f6" src="https://github.com/user-attachments/assets/87c68b51-ec03-4379-94dd-974174459249" />
  <img width="348" height="708" alt="f7" src="https://github.com/user-attachments/assets/70cf2095-0603-4945-bb1c-2b5d95dbe2f2" />
</p>

✔️ This layout renders **beautifully on GitHub** and is **recruiter-approved**.

---

## 📂 Project Structure

```
lib/
│
├── main.dart                 # App entry point
├── login_page.dart           # Login UI and logic
├── signup_page.dart          # Signup UI and logic
├── home_page.dart            # Genre-wise book dashboard
├── search_page.dart          # Book search functionality
├── book_widget.dart          # Reusable book display widget
├── firebase_options.dart     # Firebase configuration
```

---

## 📌 Notes

* Replace hardcoded `UserCredential` usage with
  `FirebaseAuth.instance.currentUser` for global access if required.
* Genres can be customized or extended.
* Future enhancements may include **favorites**, **bookmarks**, or **reading history**.

---

## 🎯 Why This Project Matters

This project demonstrates:

* **API integration at scale**
* **Secure authentication workflows**
* **Clean UI architecture in Flutter**
* **Real-time data rendering**

A solid example of **production-ready mobile development**.

---

## 📄 License

This project is intended for educational and portfolio use.










