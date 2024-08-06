# News App

A Flutter News App built using Test-Driven Development (TDD) and following the Clean Architecture principles. The app utilizes the `bloc` state management library, `http` for networking, and `get_it` for dependency injection.

## Features

- **Test-Driven Development (TDD)**: Ensuring robust and maintainable code through comprehensive testing.
- **Clean Architecture**: Structured to separate concerns and promote scalability.
- **State Management**: Managed by `bloc` for predictable state handling.
- **Networking**: Uses `http` package to fetch news from APIs.
- **Dependency Injection**: Managed by `get_it` for easy and flexible dependency management.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes with Flutter
- A code editor (VS Code, Android Studio, IntelliJ IDEA, etc.)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/bakberdy/news_app.git
    cd news_app
    ```

2. Install the dependencies:

    ```bash
    flutter pub get
    ```

### Running the App

To run the app on your local machine:

1. Ensure a device emulator is running or a physical device is connected.
2. Use the following command:

    ```bash
    flutter run
    ```

### Running Tests

To run the tests:

```bash
flutter test
```

## Project Structure

The project follows the Clean Architecture principles, organized into the following layers:

- **Data Layer**: Manages data retrieval from APIs, local storage, etc.
- **Domain Layer**: Contains business logic, including use cases and entities.
- **Presentation Layer**: Handles UI and user interaction, managed by `bloc`.

### Key Directories

- `lib/`: Main directory containing the application code.
  - `src/`:
        - `features/`: Features directory divides app by features
              - `data/`: Data sources, models, and repositories.
              - `domain/`: Entities, use cases, and repositories interfaces.
              - `presentation/`: UI widgets, pages, and BLoC components.
        - `core/`: Common utilities, constants, and error handling.
  - `injection_container.dart`: Configures dependency injection.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Bloc Package Documentation](https://bloclibrary.dev/#/)
- [Clean Architecture in Flutter](https://resocoder.com/2020/03/09/flutter-clean-architecture-tdd-dart/)

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This README provides a structured overview of the project, detailing how to get started, the project's architecture, and additional resources for development. Feel free to customize it further to fit your specific project needs.
