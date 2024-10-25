# CustomScaffold

A customizable `Scaffold` widget for Flutter with support for dark/light themes, background images, floating action buttons, and a flexible layout. This package allows you to create beautiful app screens with ease!

---

## 🌟 Features

- Easily toggle between **dark and light themes**.
- Add **custom background images** based on theme preference.
- Support for **AppBar**, **Floating Action Button (FAB)**, and **Bottom Navigation Bar**.
- Flexible **padding** and layout configuration for any screen.

---

## 📦 Installation

Add `custom_scaffold` to your `pubspec.yaml`:

## 🚀 Usage
Import the Package

    import 'package:custom_scaffold/custom_scaffold.dart';

##  Example
Here's how you can use CustomScaffold in your Flutter app:

    import 'package:flutter/material.dart';
    import 'package:custom_scaffold/custom_scaffold.dart';

    void main() => runApp(MyApp());

    class MyApp extends StatelessWidget {
            @override
            Widget build(BuildContext context) {
            return MaterialApp(
                title: 'Custom Scaffold Demo',
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                home: ScaffoldExample(),
            );
        }
    }

    class ScaffoldExample extends StatelessWidget {
            @override
            Widget build(BuildContext context) {
            return CustomScaffold(
            appBar: AppBar(
            title: Text('Home'),
            ),
            child: Center(
                child: Text(
                'Hello, World!',
                style: TextStyle(fontSize: 24),
                ),
            ),
            isDark: true, // Toggle dark or light theme
            darkBackgroundAsset: 'assets/dark_background.png',
            lightBackgroundAsset: 'assets/light_background.png',
            floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            ),
                bottomNav: BottomNavigationBar(
                items: const [
                    BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    ),
                        BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                        ),
                    ],
                ),
            );
        }
    }


## 🎨 Customization Options
* child: The main widget displayed in the scaffold body.
* isDark: Boolean to toggle between dark/light themes. Defaults to true.
* backgroundColor: Custom background color.
* appBar: The AppBar widget.
* floatingActionButton: The Floating Action Button widget.
* padding: Padding for the main content area.
* bottomNav: The Bottom Navigation Bar widget.
* darkBackgroundAsset: Asset path for the dark background image.
* lightBackgroundAsset: Asset path for the light background image.


# 📝 License
This project is licensed under the [MIT](https://choosealicense.com/licenses/mit/) License.

# 💬 Feedback
If you encounter any issues or have suggestions for improvements, please open an issue on GitHub.

# Contact For any questions or inquiries, feel free to reach out:
Author: Earbaj Md Saria 
Email: earbajsaria3@gmail.com

