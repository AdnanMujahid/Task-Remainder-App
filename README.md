# 📱 Task Reminder App

A beautiful and modern Flutter task management application with local storage, category filtering, and reminder functionality. Built with a clean Material Design interface that adapts to both light and dark themes.

## ✨ Features

### 🎯 Core Functionality
- **Task Management**: Create, edit, delete, and mark tasks as complete
- **Local Storage**: Persistent data storage using Hive database
- **Category System**: Organize tasks into Work, Personal, and Study categories
- **Smart Filtering**: Filter tasks by category with beautiful chip-based UI
- **Due Date Management**: Set specific dates and times for tasks
- **Reminder System**: Configure one-time or daily reminders for tasks

### 🎨 Beautiful UI/UX
- **Modern Design**: Clean, intuitive interface with Material Design 3
- **Dark/Light Theme**: Automatic theme switching based on system preferences
- **Smooth Animations**: Fade transitions and smooth interactions
- **Responsive Layout**: Optimized for different screen sizes
- **Visual Feedback**: Color-coded categories and status indicators
- **Statistics Dashboard**: Overview of total, pending, and completed tasks

### 📊 Smart Features
- **Overdue Detection**: Visual indicators for overdue tasks
- **Relative Time Display**: Smart date formatting (Today, Tomorrow, etc.)
- **Task Details Modal**: Comprehensive task information view
- **Confirmation Dialogs**: Safe deletion with confirmation prompts
- **Success Notifications**: Toast messages for user actions

## 🚀 Getting Started

### Prerequisites

Before running this project, make sure you have the following installed:

- **Flutter SDK** (>=3.29.0)
- **Dart SDK** (>=3.8.0)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (for Android development)
- **Xcode** (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/task-reminder-app.git
   cd task-reminder-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (if needed)
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point and Hive initialization
├── home.dart                 # Main screen with task list and statistics
├── addtaskscreenUI.dart      # Task creation and editing screen
├── taskwidgetlist.dart       # Task list components and task cards
├── taskmodel.dart           # Task data model with Hive annotations
└── hivegeneratedadapter.dart # Generated Hive adapters for serialization
```

## 🛠️ Technologies Used

### Core Framework
- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language for Flutter development

### State Management & Storage
- **Hive**: Lightweight, fast NoSQL database for local storage
- **Hive Flutter**: Flutter integration for Hive database
- **Provider**: State management solution (ready for future enhancements)

### UI/UX Libraries
- **Material Design 3**: Modern design system
- **Cupertino Icons**: iOS-style icons for cross-platform consistency

### Development Tools
- **Flutter Lints**: Code analysis and linting
- **Build Runner**: Code generation for Hive adapters
- **Hive Generator**: Automatic adapter generation

## 📱 Screenshots

### Home Screen
- Clean task list with category filtering
- Statistics dashboard showing task counts
- Modern card-based design with smooth animations

### Add/Edit Task Screen
- Intuitive form with validation
- Date and time picker integration
- Category selection with visual icons
- Reminder configuration options

### Task Details
- Comprehensive task information modal
- Quick edit and delete actions
- Visual status indicators

## 🎨 Design Features

### Color Scheme
- **Work Tasks**: Blue theme
- **Personal Tasks**: Green theme  
- **Study Tasks**: Purple theme
- **Overdue Tasks**: Red indicators

### Typography
- **Headers**: Bold, prominent text for titles
- **Body**: Clean, readable text for descriptions
- **Captions**: Subtle text for metadata

### Animations
- **Fade Transitions**: Smooth screen transitions
- **Hover Effects**: Interactive button states
- **Loading States**: Visual feedback during operations

## 🔧 Configuration

### Android Configuration
The app is configured for Android with:
- **Target SDK**: 34
- **Compile SDK**: 34
- **Java Version**: 11
- **Build Tools**: 34.0.0

### iOS Configuration
- **Minimum iOS Version**: 12.0
- **Swift Version**: 5.0
- **Xcode Version**: 14.0+

## 📦 Dependencies

### Main Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  provider: ^6.0.5
```

### Development Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  hive_generator: ^2.0.0
  build_runner: ^2.3.3
```

## 🚀 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Hive Team** for the lightweight database solution
- **Material Design Team** for the design system
- **Flutter Community** for packages and support

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/task-reminder-app/issues) page
2. Create a new issue with detailed information
3. Contact the maintainers

## 🔮 Future Enhancements

### Planned Features
- [ ] **Cloud Sync**: Backup and sync across devices
- [ ] **Push Notifications**: Real-time task reminders
- [ ] **Task Templates**: Pre-defined task templates
- [ ] **Team Collaboration**: Shared task lists
- [ ] **Analytics**: Task completion statistics and insights
- [ ] **Widgets**: Home screen widgets for quick access
- [ ] **Voice Input**: Speech-to-text for task creation
- [ ] **File Attachments**: Attach files to tasks
- [ ] **Recurring Tasks**: Automatic task repetition
- [ ] **Priority Levels**: High, medium, low priority system

### Technical Improvements
- [ ] **Unit Tests**: Comprehensive test coverage
- [ ] **Integration Tests**: End-to-end testing
- [ ] **Performance Optimization**: Faster loading and smoother animations
- [ ] **Accessibility**: Better support for screen readers
- [ ] **Internationalization**: Multi-language support
- [ ] **Offline Mode**: Enhanced offline functionality

---

**Made with ❤️ using Flutter**

*Last updated: December 2024*