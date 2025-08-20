# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SwiftUI-based iOS application called "first-ios-ai-app" that targets iOS 18.5+. The project follows standard iOS app architecture patterns using SwiftUI for the user interface and Swift Testing/XCTest for testing.

## Project Structure

```
first-ios-ai-app/
├── first-ios-ai-app/                 # Main app source code
│   ├── first_ios_ai_appApp.swift     # App entry point and main structure
│   ├── ContentView.swift             # Main UI view
│   └── Assets.xcassets/              # App icons, colors, and other assets
├── first-ios-ai-appTests/            # Unit tests using Swift Testing framework
└── first-ios-ai-appUITests/          # UI tests using XCTest framework
```

## Development Commands

### Building and Running
```bash
# Open project in Xcode
open first-ios-ai-app.xcodeproj

# Build from command line (requires xcodebuild)
xcodebuild -project first-ios-ai-app.xcodeproj -scheme first-ios-ai-app -configuration Debug -sdk iphonesimulator
```

### Testing
```bash
# Run unit tests (Swift Testing framework)
xcodebuild test -project first-ios-ai-app.xcodeproj -scheme first-ios-ai-app -destination 'platform=iOS Simulator,name=iPhone 15'

# Run UI tests (XCTest framework)
xcodebuild test -project first-ios-ai-app.xcodeproj -scheme first-ios-ai-app -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:first-ios-ai-appUITests
```

## Technical Details

- **Language**: Swift 5.0
- **Framework**: SwiftUI
- **Deployment Target**: iOS 18.5
- **Supported Devices**: iPhone and iPad (Universal)
- **Bundle Identifier**: mauricioacosta.first-ios-ai-app
- **Testing**: Swift Testing for unit tests, XCTest for UI tests
- **Xcode Version**: 16.4+

## Architecture Notes

- **App Entry Point**: `first_ios_ai_appApp.swift` contains the main App struct with `@main` attribute
- **Main View**: `ContentView.swift` serves as the primary view containing the app's UI
- **SwiftUI Previews**: Available for rapid UI development and testing
- **Asset Management**: Uses Asset Catalog for managing app icons, colors, and other resources

## Implementation Details

### Voice-Activated Grocery List Features
The app has been updated with a comprehensive voice-activated grocery list interface featuring:

- **Glassmorphism Design**: Modern iOS glass material effects with backdrop blur and transparency
- **Voice Recording**: Large circular button with 3 animated states (idle/recording/processing)
- **Smart List Management**: Checkable grocery items with smooth completion animations
- **Progress Tracking**: Sticky progress bar showing completion percentage
- **Mobile-Optimized**: Designed for iPhone 16 Pro Max with proper safe areas

### File Structure
```
first-ios-ai-app/
├── ContentView.swift                 # Main app interface with glassmorphic layout
├── GroceryItem.swift                # Data model for grocery items
├── RecordingState.swift             # Enum for voice recording states
├── GroceryListViewModel.swift       # ObservableObject for state management
├── VoiceRecordingButton.swift       # Animated voice recording interface
├── GroceryListItem.swift           # Individual grocery item with checkbox
├── ProgressBar.swift               # Sticky completion progress tracker
├── GlassmorphicBackground.swift    # Background gradients and radial overlays
├── GlassmorphicModifier.swift      # Reusable glassmorphism ViewModifier
└── first_ios_ai_appApp.swift       # App entry point
```

### Key Components

#### GlassmorphicModifier
- Reusable ViewModifier for consistent glass effects
- Configurable opacity, corner radius, and border opacity
- Uses `.ultraThinMaterial` with custom gradient overlays

#### GroceryListViewModel
- `@ObservableObject` managing app state
- Handles item completion, voice recording simulation
- Provides computed properties for progress tracking

#### VoiceRecordingButton
- Three distinct states with visual feedback
- SF Symbols for microphone icons
- Pulse animation during recording, spin during processing

#### GroceryListItem
- Custom checkbox with green completion state
- Press animations and touch feedback
- Glassmorphic card styling with conditional opacity

## Code Conventions

- Follow standard Swift naming conventions (camelCase for variables/functions, PascalCase for types)
- Use SwiftUI's declarative syntax for UI components
- Utilize SF Symbols for consistent iOS iconography
- Implement `@ObservableObject` pattern for state management
- Use `.glassmorphic()` modifier for consistent visual styling
- Maintain separation between UI and business logic
- Use Swift Testing's modern testing syntax with `@Test` attributes for new unit tests
- Use XCTest for UI automation testing

## Testing Strategy

- **Unit Tests**: Located in `first-ios-ai-appTests/` using Swift Testing framework
- **UI Tests**: Located in `first-ios-ai-appUITests/` using XCTest framework
- Test files follow the pattern `[TargetName]Tests.swift` and `[TargetName]UITests.swift`