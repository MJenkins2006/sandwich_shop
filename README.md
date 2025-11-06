# Sandwich Shop App 🥪

A Flutter-based app for ordering sandwhiches

## Features

- **Quantity Management**: Add or remove sandwiches
- **Sandwich Customization**: Choose between six-inch and footlong sizes
- **Bread Selection**: Select from white, wheat, or wholemeal
- **Order Notes**: Add special instructions (e.g., "no onions", "extra cheese")
- **Visual Feedback**: Emoji-based display showing sandwich count
- **Smart Constraints**: Buttons automatically disable at min/max limits
- **Configurable Limits**: Set maximum order quantity per session

## Installation and Setup

### Prerequisites

- **Operating System**: Windows, macOS, or Linux
- **Flutter SDK**: Version 3.0.0 or higher ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: Included with Flutter
- **IDE**: VS Code (recommended) or Android Studio
- **Git**: For cloning the repository

### Clone the Repository

```bash
git clone https://github.com/yourusername/sandwich_shop.git
cd sandwich_shop
```

### Installation Steps

1. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```
   Ensure all required dependencies are installed.

2. **Install project dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   For development:
   ```bash
   flutter run
   ```
   
   For specific device:
   ```bash
   flutter devices                    # List available devices
   flutter run -d <device-id>         # Run on specific device
   ```

4. **Build for production**
   ```bash
   # Android APK
   flutter build apk --release
   
   # iOS (macOS only)
   flutter build ios --release
   ```

## Usage Instructions

### Basic Workflow

1. **Launch the app** - The main screen displays the current order with quantity set to 0
2. **Add sandwiches** - Click the green "Add" button to increase quantity
3. **Customize your order**:
   - Toggle the switch to select six-inch or footlong size
   - Use the dropdown menu to choose bread type
   - Enter special instructions in the notes field
4. **Remove sandwiches** - Click the red "Remove" button to decrease quantity
5. **View order summary** - Order details update in real-time at the top

### Feature Details

#### Quantity Controls
- **Add Button** (Green): Increases sandwich count by 1
- **Remove Button** (Red): Decreases sandwich count by 1
- Buttons automatically disable when reaching 0 or maximum limit
- Maximum quantity is configurable (default: 5)

#### Size Selection
- Use the **Switch** to toggle between:
  - Left position: Six-inch
  - Right position: Footlong (default)

#### Bread Type Selection
- Click the **Dropdown Menu** to choose from:
  - White (default)
  - Wheat
  - Wholemeal

#### Order Notes
- Click the **text field** labeled "Add a note"
- Type special instructions (e.g., "no onions", "extra cheese")
- Notes display in real-time in the order summary
- Shows "No notes added." when field is empty

### Configuration Options

Modify maximum quantity in `lib/main.dart`:

```dart
home: OrderScreen(maxQuantity: 10),  // Change to your desired limit
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## Screenshots

### Main Order Screen
![Main Screen](screenshots/main_screen.png)
*Order interface with quantity controls, size toggle, bread selection, and notes field*

### Order Summary
![Order Summary](screenshots/order_summary.png)
*Real-time order display showing quantity, size, bread type, and notes*

### Maximum Limit Reached
![Max Limit](screenshots/max_limit.png)
*Add button disabled when maximum quantity is reached*

> **Note**: Add actual screenshots to a `screenshots/` folder in your project

## Project Structure

```
sandwich_shop/
├── lib/
│   ├── main.dart                    # App entry point and UI components
│   ├── views/
│   │   └── app_styles.dart          # Text styles and theme constants
│   └── repositories/
│       └── order_repository.dart    # Order state management logic
├── test/
│   └── widget_test.dart             # Unit and widget tests
├── pubspec.yaml                     # Project dependencies
├── README.md                        # This file
└── screenshots/                     # App screenshots (create this folder)
```

### Key Files

- **`main.dart`**: Contains all UI widgets and state management
  - `App`: Root MaterialApp widget
  - `OrderScreen`: Main stateful widget
  - `StyledButton`: Reusable button component
  - `OrderItemDisplay`: Order summary display widget
  
- **`order_repository.dart`**: Business logic for order quantity
  - Handles increment/decrement operations
  - Enforces min/max constraints
  - Provides state validation methods

- **`app_styles.dart`**: Centralized styling
  - `heading1`: AppBar title style
  - `normalText`: Body text style

## Technologies Used

### Framework & Language
- **Flutter**: 3.0+ - UI framework
- **Dart**: 2.17+ - Programming language

### Core Packages
- `flutter/material.dart` - Material Design components
- Built-in state management (StatefulWidget)

### Development Tools
- **VS Code** - Primary IDE
- **Flutter DevTools** - Debugging and profiling
- **Git** - Version control

### Design Patterns
- Repository pattern for state management
- StatefulWidget for reactive UI
- Separation of concerns (UI, business logic, styling)

## Known Issues and Limitations

### Current Limitations
- ❌ Orders are not persisted (lost on app restart)
- ❌ No backend integration or database
- ❌ Single order at a time (no cart functionality)
- ❌ No checkout or payment processing
- ❌ Limited to predefined bread types and sizes

### Planned Improvements
- [ ] Add local storage (SharedPreferences or SQLite)
- [ ] Implement shopping cart with multiple orders
- [ ] Add more customization options (toppings, sauces)
- [ ] Integrate with backend API
- [ ] Add order history functionality
- [ ] Implement user authentication
- [ ] Add price calculation and payment integration
- [ ] Support for internationalization (i18n)

### Known Bugs
- None currently reported

### Contributing
Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact Information

**Matthew** - Developer
- 📧 Email: your.email@example.com
- 💼 LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- 🐙 GitHub: [@yourusername](https://github.com/yourusername)
- 🌐 Portfolio: [yourportfolio.com](https://yourportfolio.com)