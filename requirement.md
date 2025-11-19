# Cart Modification Feature Requirements

## 1. Feature Description and Purpose

The Cart Modification feature enables users of the Sandwich Shop Flutter app to manage the contents of their cart before checkout. Users can adjust the quantity of each sandwich or remove items. Editing sandwich details (such as bread type or size) is not supported on the cart page; users must add a new item from the order screen if they wish to change sandwich options. This feature aims to provide a flexible and user-friendly shopping experience, ensuring users can easily correct mistakes or change their order without starting over.

---

## 2. User Stories

### 2.1. Adjust Quantity

- **As a user**, I want to increase or decrease the quantity of a sandwich in my cart, so I can order the exact number I want.
- **As a user**, I want the cart to automatically remove an item if I decrease its quantity below 1, so my cart never contains items with zero or negative quantity.

### 2.2. Remove Item

- **As a user**, I want to remove a sandwich from my cart with a single action, so I can quickly update my order if I change my mind.

### 2.3. Feedback and UI Responsiveness

- **As a user**, I want the cart and total price to update immediately when I make changes, so I always see an accurate summary of my order.
- **As a user**, I want to receive feedback (such as a snackbar) when I remove or update an item, so I know my action was successful.
- **As a user**, I want to see a clear message if my cart is empty, so I know I need to add items before checking out.

---

## 3. Acceptance Criteria

### 3.1. Quantity Adjustment

- [ ] Each cart item displays "+" and "–" buttons for quantity adjustment.
- [ ] Tapping "+" increases the quantity by 1.
- [ ] Tapping "–" decreases the quantity by 1.
- [ ] If the quantity is reduced below 1, the item is removed from the cart.
- [ ] The total price updates automatically and accurately.
- [ ] The UI updates immediately to reflect changes.

### 3.2. Remove Item

- [ ] Each cart item has a "Remove" button (e.g., trash icon).
- [ ] Tapping "Remove" deletes the item from the cart.
- [ ] The total price updates accordingly.
- [ ] A snackbar or similar feedback is shown when an item is removed.

### 3.3. General UI and Behavior

- [ ] All changes are reflected immediately in the UI.
- [ ] The cart's total price is always accurate.
- [ ] The cart handles empty states gracefully (e.g., displays a message if empty).
- [ ] The UI prevents negative quantities.
- [ ] User feedback is provided for all cart modification actions.

---

## 4. Subtasks

1. Implement "+" and "–" quantity adjustment buttons for each cart item.
2. Implement logic to remove an item if its quantity is reduced below 1.
3. Add a "Remove" button for each cart item.
4. Ensure the total price and UI update immediately after any change.
5. Provide user feedback (snackbar) for remove and update actions.
6. Handle empty cart states with a clear message.

---

# Prompt for LLM: Add Sign-Up / Sign-In UI (Mock)

- **Project**: Sandwich Shop Flutter app located under `lib/` in a typical Flutter project.
- **Goal**: Add Sign-Up and Sign-In UI, plus a bottom button on the Order screen that starts the Sign-In flow. No real authentication or backend calls — use a simple local/mock solution.
- **Constraints**: 
	- Keep changes minimal and consistent with existing code style.
	- Add small files under `lib/views/auth/` and `lib/services/`.
	- Avoid third-party auth packages; optionally use `shared_preferences` only if persistence is desired.
	- All changes must be testable with `flutter test`.

**Deliverables**
- New files:
	- `lib/views/auth/sign_in.dart`
	- `lib/views/auth/sign_up.dart`
	- `lib/services/auth_service.dart`
- Modified files:
	- The Order screen file (likely in `lib/views/` — locate it; if not present, modify `lib/main.dart`)
	- App routing to register new routes (use existing `MaterialApp.routes` if present)
- Tests:
	- `test/widgets/auth_flow_test.dart` — widget tests for Sign-Up/Sign-In navigation and flows
	- `test/widgets/order_button_test.dart` — test for button presence/navigation on the Order screen
- Documentation:
	- A one-paragraph README note explaining how the mock auth works and how to run tests
- Patch:
	- Provide apply_patch-style diffs for all changes

**Acceptance Criteria**
- **Sign-Up screen** (`/sign-up`):
	- Fields: full name, email, password
	- Basic validation: non-empty, password >= 6 chars
	- On submit: create a local user and navigate to the Order screen
- **Sign-In screen** (`/sign-in`):
	- Fields: email, password
	- Basic validation and match against locally stored credentials (or in-memory user)
	- On success: return to the Order screen and display the user’s name
- **Order screen**:
	- Bottom-aligned button labeled “Sign in / Register” (or “Account” when signed in)
	- Tapping the button opens the Sign-In screen
	- When signed in, the Order screen displays the signed-in user’s name
- **No networking**: No external authentication or network calls made
- **Tests**:
	- Widget tests confirm navigation and local sign-in/sign-up behavior
	- All tests pass with `flutter test`

**Implementation Guidance**
1. Locate the Order screen file: search `lib/views/` for `order`, `checkout`, `cart`, or `order_screen`. If not found, update `lib/main.dart`.
2. Add `lib/services/auth_service.dart`:
	 - Implement a simple singleton `AuthService`:
		 - `Future<bool> signUp(String name, String email, String password)`
		 - `Future<bool> signIn(String email, String password)`
		 - `String? get currentUserName`
	 - Optionally persist a single user using `shared_preferences` (optional).
3. Add UI screens:
	 - `SignUpScreen` (`/sign-up`): `StatefulWidget` with form, validation, calls `AuthService.signUp`, and navigates back to Order screen on success.
	 - `SignInScreen` (`/sign-in`): `StatefulWidget` with form, validation, calls `AuthService.signIn`, and navigates back on success.
	 - Use the app’s existing theme/typography.
4. Update the Order screen:
	 - Add a bottom `SafeArea` button with consistent styling that opens `/sign-in`.
	 - When a user is signed in, change the button text (e.g., to the user’s name) or offer “Sign out”.
5. Register routes:
	 - Add entries to `MaterialApp.routes`, keeping changes minimal.
6. Tests:
	 - Use `testWidgets` to pump the Order screen, verify the button exists, tap to navigate, fill forms, submit, and assert navigation + presence of user name.
7. Patches:
	 - Provide `apply_patch` diffs for changed files.
	 - Run `flutter test` and fix any failing tests before finalizing.

**Helpful Questions (if unclear)**
- “Which file is the Order screen located in under `lib/views/`?”
- “Do you prefer `shared_preferences` for persistence, or purely in-memory mock auth?”

**How to run tests**
```powershell
flutter test
```

**Tone & scope**
- Conservative, minimal changes focused on function and testability.
- Avoid unrelated refactors.

Would you like me to create this file now in the repo (e.g., `prompt_for_llm.md`) or implement the feature directly and produce apply_patch diffs?

# Prompt for LLM: Add Global Navigation Drawer

Goal

- Add a single, reusable navigation drawer accessible from all app screens in the Sandwich Shop Flutter app. The drawer should provide navigation to: Order screen, Sign Up, Sign In, Cart, and Checkout screens.

Context

- Project root: `lib/` contains the app UI. Keep changes minimal and consistent with existing app patterns and routing.
- No network requests or third-party auth—drawer only handles navigation.

User stories

- As a user, I want a consistent drawer available from every primary screen so I can quickly move between Order, Sign Up, Sign In, Cart, and Checkout.
- As a developer, I want the drawer implemented once and reused across screens so maintenance is easy.

Behavior and UX

- The drawer opens from the left via a hamburger menu in the app bar of primary screens.
- Drawer items: `Orders`, `Sign Up`, `Sign In`, `Cart`, `Checkout` (order and naming consistent with existing routes).
- When the user is signed in, show their name and a `Sign out` item instead of `Sign In`/`Sign Up` (or show both plus the name, as preferred). Use the existing `AuthService` (or mock) to detect sign-in state.
- Tapping a drawer item navigates to the corresponding route using the app's `Navigator` / named routes.
- Drawer should be accessible: proper semantics, tappable area, and support for screen readers.

Implementation guidance for the LLM

- Create a single `Widget` named `AppDrawer` under `lib/views/common/app_drawer.dart` (or reuse a `views/shared/` folder) that builds the drawer contents and accepts an optional `String? currentRoute` to highlight the active item.
- Add a small helper `Widget` or function to the `AppBar` construction used by main screens to include the hamburger menu that opens `AppDrawer`.
- Update primary screen files (e.g., Order, Cart, Checkout, SignIn, SignUp) to use the shared `AppBar` or include the hamburger menu so the drawer is available on each screen. Keep modifications minimal — ideally just add `drawer: AppDrawer(),` to `Scaffold` where appropriate.
- Register or confirm named routes exist in `MaterialApp.routes` (e.g., `/orders`, `/sign-up`, `/sign-in`, `/cart`, `/checkout`) and add them if missing. Use the app's existing route names and structure where possible.

Deliverables (what to create/modify)

- New file: `lib/views/common/app_drawer.dart` — the reusable Drawer widget.
- Modified files: primary screen widgets (add `drawer: AppDrawer()` to their `Scaffold`), and `lib/main.dart` or the file that sets up `MaterialApp.routes` to ensure the routes above are registered.
- Tests: add `test/widgets/drawer_navigation_test.dart` with widget tests that:
	- Pump a screen with the drawer present and verify the hamburger menu exists.
	- Open the drawer, tap the `Sign In` and `Sign Up` items, and assert navigation to corresponding routes.
	- Verify that when an `AuthService` mock reports a signed-in user, the drawer displays the user's name and a `Sign out` action.

Acceptance criteria

- Drawer is accessible from all primary screens (Orders, Cart, Checkout, Sign In, Sign Up).
- Drawer items navigate using named routes present in `MaterialApp.routes`.
- Signed-in state is reflected in the drawer UI (user name and a sign-out option).
- Widget tests exist for navigation and signed-in display and pass with `flutter test`.

Constraints and assumptions

- Do not add heavy refactors; prefer adding `drawer: AppDrawer()` to existing `Scaffold`s.
- No external network or auth libraries — use the existing `AuthService` or the mock `lib/services/auth_service.dart` that the project contains or will contain.
- Keep theming and styling aligned with current app theme.

Notes for reviewers / future LLM

- If multiple `Scaffold` locations exist, prefer adding the drawer to the app's main screens only (places users would expect navigation). If unsure, add to `lib/main.dart`'s root `Scaffold` or to the `Order` screen and any other top-level screens.
- Keep the drawer implementation small, focused, and testable. Provide clear unit/widget tests that validate navigation and conditional user UI.

How to run tests

Run:

```powershell
flutter test
```

If you prefer, I can implement the `AppDrawer` and tests now and provide apply_patch diffs.