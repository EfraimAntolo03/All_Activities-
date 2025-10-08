# Pizza Hot

A small Flutter app that demonstrates 10 foundational tasks in one cohesive project.

## Project Structure

```
lib/
  models/          # Data models (e.g., Pizza)
  services/        # App services (e.g., PizzaService)
  widgets/         # Reusable widgets (e.g., CustomButton)
  views/
    home/          # Home + Counter (stateless/stateful demos)
    menu/          # Menu screen with staggered grid
    settings/      # Material/Cupertino variants of same UI
  main.dart        # App shell with Drawer + BottomNavigationBar
```

Why this structure: it separates concerns—data, services, reusable components, and screens—so each layer stays focused and maintainable.

## What’s Implemented (Tasks 1–10)

1. New Flutter project organized into `models`, `views`, `widgets`, `services`.
2. Hello World using only a StatelessWidget at `views/home/home_page.dart` (`HomePage`).
3. Converted to StatefulWidget with counter (`CounterPage`).
4. Custom reusable `CustomButton` used on Home, Menu, and Settings.
5. Material and Cupertino widgets for the same screen (`SettingsPage`).
6. Two+ pages with navigation via Drawer and `BottomNavigationBar` in `RootScaffold`.
7. Widget tree diagram below explains hierarchy.
8. Refactoring into smaller reusable widgets: `CustomButton`, `_PizzaCard`.
9. Third-party package: `flutter_staggered_grid_view` used in `MenuPage`.
10. This README documents structure and rationale.

## Widget Tree (High Level)

```
MaterialApp (title: Pizza Hot)
  └─ RootScaffold (Stateful)
     ├─ AppBar(title: Pizza Hot)
     ├─ Drawer
     │   ├─ ListTile(Home)
     │   ├─ ListTile(Menu)
     │   └─ ListTile(Settings)
     ├─ Body (Indexed by _currentIndex)
     │   ├─ index 0: HomePage (Stateless)
     │   │   ├─ Text(Welcome to Pizza Hot!)
     │   │   ├─ CustomButton(Go to Counter)
     │   │   └─ CustomButton(Cupertino Modal)
     │   ├─ index 1: MenuPage (Stateless)
     │   │   └─ MasonryGridView → _PizzaCard×N (image, text, CustomButton)
     │   └─ index 2: SettingsPage (Stateful)
     │       ├─ Material UI (Switches, Dialog) or
     │       └─ Cupertino UI (CupertinoSwitch, CupertinoAlertDialog)
     └─ BottomNavigationBar(Home, Menu, Settings)
```

## Run

```
flutter pub get
flutter run
```

## Notes

- Images use placeholder URLs.
- The staggered grid comes from `flutter_staggered_grid_view`.
- This project is designed for quick exploration of multiple Flutter basics in one app.
