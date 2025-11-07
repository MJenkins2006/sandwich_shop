# Sandwich Shop App

A Flutter-based app for ordering sandwhiches

## Features

- **Quantity Management**: Add or remove sandwiches
- **Sandwich Customization**: Choose between six-inch and footlong sizes, toasted or untoasted
- **Bread Selection**: Select from white, wheat, or wholemeal
- **Order Notes**: Add special instructions (e.g., "no onions", "extra cheese")
- **Visual Feedback**: Emoji-based display showing sandwich count
- **Smart Constraints**: Buttons automatically disable at min/max limits
- **Configurable Limits**: Set maximum order quantity per session
- **Real-time pricing**: See price changes in real-time depending on type and quantity

## Installation and Setup

### Prerequisites

- **Operating System**: Windows, macOS, or Linux
- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Included with Flutter
- **IDE**: VS Code (recommended) or Android Studio
- **Git**: For cloning the repository

### Clone the Repository

```bash
git clone https://github.com/MJenkins2006/sandwich_shop.git
cd sandwich_shop
```

## Usage Instructions

### Basic Workflow

1. **Launch the app** - The main screen displays the current order with quantity set to 0
2. **Add sandwiches** - Click the green "Add" button to increase quantity
3. **Customize your order**:
   - Toggle the switch to select six-inch or footlong size
   - Toggle the switch to select toasted or untoasted
   - Use the dropdown menu to choose bread type
   - Enter special instructions in the notes field
4. **Remove sandwiches** - Click the red "Remove" button to decrease quantity
5. **View order summary** - Order details update in real-time

### Feature Details

#### Size Selection
- Use the **Switch** to toggle between:
  - Left position: Six-inch
  - Right position: Footlong (default)

#### Bread Cooked Selection
- Use the **Switch** to toggle between:
  - Left position: untoasted (default)
  - Right position: toasted

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

### Running Tests

```bash
flutter test
```

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
└── screenshots/                      
```
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

**Matthew** - Developer
- GitHub: [@MJenkins2006](https://github.com/MJenkins2006)