# Kerjain — Task Management App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)

Kerjain is a Flutter-based task management application designed to help users organize activities, deadlines, and daily progress in a simple yet effective way. The app supports local storage using SQLite and utilizes Clean Architecture (Presentation, Domain, Data) with Riverpod as state management.

## 🚀 Key Features

- ✍️ **Add, edit, and delete tasks** — Manage tasks with ease
- 📅 **Set due dates** — Define deadlines for each task
- 🔄 **Task lifecycle** — Status: Not Started → In Progress → Done
- 🧠 **Task classification** — Automatic sorting based on status and deadline
- 📊 **Statistics summary** — View task overview on Home page
- 🗂️ **Complete navigation** — Home, History, Detail, Add Task
- 💾 **Local storage** — Data stored with SQLite

## 📚 Tech Stack

| Technology | Description |
|-----------|-----------|
| **Flutter** | Main UI framework |
| **Riverpod** | State management |
| **SQLite (sqflite)** | Persistent local storage |
| **Dart** | Primary language |
| **Google Material** | UI Components |

## 📁 Project Structure

```
lib/
├── presentation/     # UI Layer (Screens, Widgets)
├── domain/          # Business Logic (Entities, Use Cases)
├── data/            # Data Layer (Models, Repository, Database)
└── main.dart        # Entry point
```

## 🛠️ Installation

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter plugin

### Installation Steps

1. **Clone repository**
   ```bash
   git clone https://github.com/Hypes-Astro/kerjain-v2-flutter
   cd kerjain
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📱 Usage Guide

1. **Add New Task**
   - Tap the "+" button on the main page
   - Fill in task details (name, description, due date)
   - Save the task

2. **Edit Task**
   - Tap on the task you want to edit
   - Modify the necessary information
   - Save changes

3. **Update Status**
   - Tap on a task to view details
   - Change status: Not Started → In Progress → Done

4. **View Statistics**
   - Check task summary on Home page
   - View task history on History page

## 🏗️ Architecture

Kerjain uses **Clean Architecture** with three main layers:

### 1. Presentation Layer
- Handles UI and user interactions
- Widgets and Screen components
- State management with Riverpod

### 2. Domain Layer
- Application business logic
- Entities and Use Cases
- Repository interface (abstract)

### 3. Data Layer
- Repository implementation
- Local database (SQLite)
- Data models and mappers

## 🔧 Main Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.x.x
  sqflite: ^2.x.x
  path: ^1.x.x
  intl: ^0.x.x
```

## 🤝 Contributing

Contributions are highly appreciated! Please fork this repository and submit a pull request.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Create a Pull Request

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

## 📞 Contact

- Email: alif.anwar@loglines.co
- GitHub: [@AlifAnwar](https://github.com/Hypes-Astro/)

---

⭐ Don't forget to star this project if you find it useful!