# One Cask At A Time - Flutter Assessment

A whiskey/bottle collection management app built for the Pixelfield Flutter Developer Assessment.

---

## Time Spent

**Total Time: ~3.5 hours**

| Task | Time |
|------|------|
| Project setup & architecture | ~30 min |
| UI Implementation (Collection + Details screens) | ~1.5 hours |
| Data layer (models, repositories, cubits) | ~45 min |
| Caching & offline mode implementation | ~30 min |
| Animations & polish | ~15 min |

---

## Architecture Overview

The project follows **Clean Architecture** principles with a feature-first folder structure:

```
lib/
├── app/                    # App entry point, routing, theme
├── core/                   # Shared utilities, services, DI
│   ├── api_service/        # API client (Dio)
│   ├── app_preferences/    # Local storage (Hive) + Caching
│   ├── di/                 # Dependency injection (GetIt)
│   ├── offline/            # Offline data source & filters
│   └── services/           # Connectivity service
├── features/
│   ├── home/               # Collection feature
│   │   ├── data/           # Repository implementations
│   │   ├── domain/         # Models, repository interfaces
│   │   └── presentation/   # Cubits, screens, widgets
│   └── product/            # Product detail feature
│       ├── data/
│       ├── domain/
│       └── presentation/
└── utils/                  # Helpers, extensions
```

### Key Architecture Decisions

1. **Feature-First Structure**: Each feature is self-contained with its own data, domain, and presentation layers. This improves scalability and maintainability.

2. **Repository Pattern**: Abstracts data sources from the UI layer, making it easy to swap between mock JSON and a real API.

3. **DataState Wrapper**: A generic state wrapper that handles `initial`, `loading`, `loaded`, and `failure` states consistently across all data operations.

---

## State Management: BLoC Pattern

The app uses **flutter_bloc** for state management with **Cubit** (simplified BLoC):

- `CollectionCubit` - Manages collection list state, loading, and refresh
- `ProductDetailCubit` - Manages product detail state and status updates

**Why Cubit over full BLoC?**
- Cubits are simpler for CRUD operations without complex event transformations
- Less boilerplate while maintaining testability and separation of concerns
- Events can be added later if needed (Cubit is a subset of BLoC)

---

## Data Handling

### Mock JSON Data
- Mock data files are stored in `assets/mock/`
- Data is loaded via `ApiService` which simulates network delay
- **Internet connection is required** to fetch mock data (as per requirements)

### Connectivity Check
- Uses `ConnectivityService` to check network status before API calls
- Returns cached data when offline

---

## Caching Implementation

Caching is implemented using **Hive** through `AppPreferences`:

```dart
// Cache is checked first, then refreshed after successful fetch
Future<RepositoryResponse<List<CollectionModel>>> getCollections() async {
  // 1. Return cached data immediately if available
  // 2. Fetch fresh data from API (requires internet)
  // 3. Update cache with new data
  // 4. Return fresh data
}
```

**Cache Strategy:**
- Collections and products are cached as JSON in Hive
- Cache is automatically refreshed on successful API fetch
- When offline, cached data is served seamlessly

---

## Offline Mode with Filtering

The offline solution supports **future filtering** through `OfflineDataSource`:

```dart
class OfflineDataSource {
  List<ProductModel>? queryProducts({ProductFilter? filter});
  List<CollectionModel>? queryCollections({CollectionFilter? filter});
}
```

**Filter Classes:**
- `ProductFilter` - Filter by distillery, region, country, type, age range, search query
- `CollectionFilter` - Filter by collection ID, search query
- Both support sorting (ascending/descending)

This architecture allows adding filter UI in the future without changing the data layer.

---

## Packages Used

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter_bloc** | ^9.1.1 | State management using BLoC/Cubit pattern |
| **bloc** | ^9.1.0 | Core BLoC library |
| **get_it** | ^9.2.0 | Dependency injection - simple service locator pattern |
| **hive_flutter** | ^1.1.0 | Fast, lightweight local storage for caching |
| **equatable** | ^2.0.7 | Value equality for models and states |
| **go_router** | ^17.0.1 | Declarative routing with deep linking support |
| **dio** | ^5.9.0 | HTTP client (used for loading mock JSON) |
| **flutter_svg** | ^2.2.3 | SVG asset rendering |
| **youtube_player_flutter** | ^9.1.3 | Embedded YouTube player for tasting notes videos |
| **google_fonts** | ^6.3.3 | Custom typography (Libre Caslon Text, DM Sans) |
| **toastification** | ^3.0.3 | Toast notifications for user feedback |
| **shimmer** | ^3.0.0 | Loading skeleton animations |
| **smooth_page_indicator** | ^2.0.1 | Onboarding page indicators |
| **flutter_phoenix** | ^1.1.1 | App restart capability |
| **permission_handler** | ^12.0.1 | Runtime permissions |
| **very_good_analysis** | ^10.0.0 | Strict lint rules for code quality |

### Why These Packages?

- **Hive over SharedPreferences**: Faster for structured data, supports complex types, better for caching large JSON objects
- **GetIt over Provider for DI**: Cleaner separation - services don't need BuildContext, can be accessed anywhere
- **go_router**: Official Flutter team recommendation for declarative routing
- **Dio over http**: More powerful - interceptors for logging/auth, better error handling
- **very_good_analysis**: Enforces strict code quality standards from the start

---

## Implemented Screens

### 1. My Collection Screen
- Grid layout displaying user's bottle collection
- Pull-to-refresh functionality
- Loading skeleton states
- Empty state handling
- Error state with retry option

### 2. Product Details Screen
- Full product information with tabbed navigation:
  - **Details Tab**: Distillery, region, age, ABV, cask info, etc.
  - **Tasting Notes Tab**: YouTube video player, nose/palate/finish notes, user notes
  - **History Tab**: Timeline of bottle's journey with attachments
- Bottle status dropdown (Unopened/Opened/Empty)
- Animated tab transitions

### 3. Onboarding Flow
- Multi-page onboarding with page indicators
- Skip/Continue navigation

---

## Animations

- **Tab switching**: Fade + slide transitions between Details/Tasting/History tabs
- **Pull-to-refresh**: Native RefreshIndicator with branded color
- **Loading states**: Shimmer effect on collection grid
- **Content transitions**: AnimatedSize + AnimatedSwitcher for smooth tab content changes

---

## Suggested Improvements

If I were to continue developing this app, here are improvements I would consider:

1. **Image Caching**: Currently using static assets. With a real API, would leverage `cached_network_image` for proper image caching with placeholder/error widgets.

2. **Search Implementation**: The filter classes (`ProductFilter`, `CollectionFilter`) are ready - just needs UI components (search bar, filter chips, bottom sheet filters).

3. **Pagination**: For large collections, implement infinite scroll with cursor-based pagination in the repository layer.

4. **Unit Tests**: Add comprehensive tests for:
   - Cubits (state transitions)
   - Repositories (data flow)
   - OfflineDataSource (filtering logic)

5. **Error Handling**: Add more granular error types (`NetworkError`, `CacheError`, `ValidationError`) for better user-facing messages.

6. **Accessibility**: Add semantic labels, proper contrast ratios, and screen reader support.

---

## Getting Started

### Prerequisites
- Flutter 3.35.0+
- Dart 3.9.0+

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/pixelfield_test.git

# Navigate to project
cd pixelfield_test

# Install dependencies
flutter pub get

# Run the app (development flavor)
flutter run --flavor development --target lib/main_development.dart
```

### Available Flavors
- `development` - Debug mode with logging
- `staging` - Pre-production testing
- `production` - Release build

---

## Project Structure Highlights

```
lib/
├── core/
│   ├── app_preferences/
│   │   └── app_preferences.dart      # Hive-based caching
│   ├── offline/
│   │   ├── offline_data_source.dart  # Queryable offline cache
│   │   ├── product_filter.dart       # Product filtering
│   │   └── collection_filter.dart    # Collection filtering
│   └── di/
│       └── app_modules.dart          # GetIt service registration
├── features/
│   ├── home/
│   │   ├── data/repository/
│   │   │   └── collection_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── models/collection_model.dart
│   │   │   └── repository/collection_repository.dart
│   │   └── presentation/
│   │       ├── cubit/collection_cubit.dart
│   │       └── views/collection_screen.dart
│   └── product/
│       └── ... (similar structure)
└── utils/helpers/
    ├── data_state.dart               # Generic async state wrapper
    └── repository_response.dart      # Unified API response type
```

---

## Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

---

## Contact

If you have any questions about the implementation or would like me to walk through any part of the code, please feel free to reach out.
