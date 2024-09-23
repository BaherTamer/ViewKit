# ViewKit
**ViewKit** is a customizable `Swift` package that provides a collection of reusable `SwiftUI` components. This package helps accelerate the development process by offering pre-built UI elements, complete with flexible configurations.

<br/>

## 📝 Requirements
- Xcode 16.0+
- iOS 15.0+

<br/>

## ⬇️ Installation
#### 🔨 For Xcode Projects
1. In Xcode, select **Add Packages** from the File menu.
2. Enter `https://github.com/BaherTamer/ViewKit` in the search field.
3. Click **Add Package** (Set the Dependency Rule to Up to Next Major Version)
4. After adding the package, you will be able to import **ViewKit** in your project by using.

``` swift
import ViewKit
```

<br/>

#### 📦 For Swift Packages
Add a dependency in your `Package.swift`

``` swift
dependencies: [
    .package(url: "https://github.com/BaherTamer/ViewKit.git", .upToNextMajor(from: "1.0.0"))
]
```

<br/>

## ⚙️ Configuration
Before using **ViewKit**, certain configurations must be added to your project’s `AppDelegate` to customize package behavior. Inside the `application(_:didFinishLaunchingWithOptions:)` method, configure the package by setting the necessary properties in `ViewKitConfig.shared`. Here’s an example of setting the configuration:

``` swift
// Set the app's primary tint color for ViewKit components
ViewKitConfig.shared.appTintColor = .blue

// Set a custom placeholder image for CachedAsyncImage
ViewKitConfig.shared.placeholderImage = Image(.placeholder)
```

<br/>

## 🛡️ SwiftSafeUI Integration

**ViewKit** uses **SwiftSafeUI** to ensure compatibility across iOS versions by handling `SwiftUI` deprecations. It automatically provides alternatives for deprecated features, ensuring **ViewKit** components work seamlessly across different iOS versions.

In addition, developers can also directly use **SwiftSafeUI** functions and modifiers from **ViewKit** to manage deprecations in their own `SwiftUI` views.

For more details, visit the [SwiftSafeUI GitHub repository](https://github.com/BaherTamer/SwiftSafeUI).

<br/>

## 📜 Explore Components
For a detailed overview of all the components, modifiers, and extensions provided in this package, please visit the [Wiki](https://github.com/BaherTamer/ViewKit/wiki).

The wiki includes documentation, examples, and usage instructions for each component, ensuring you can integrate them smoothly into your projects.

<br/>

## 🧑‍💻 Contributing
**When adding new components, please follow these guidelines:**

1. **Documentation**: Every component must be documented with clear examples on how to use it.
2. **Wiki:** Update the wiki with usage instructions and examples for the new component.
3. **Unit Tests:** If the component includes any testable logic, please ensure you write unit tests to cover key scenarios.
4. **Reusable Examples:** Create at least three example use cases to verify that the component is reusable in different contexts. These examples should not be included in the package code but are for your validation purposes.

<br/>

## ⚖️ License
**ViewKit** is available under the `MIT` license. See the [LICENSE](LICENSE) file for more details.
