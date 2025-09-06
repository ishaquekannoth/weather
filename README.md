Weather App 🌤️
This is a modern, feature-rich weather application built with Flutter. It provides accurate, real-time weather information with a focus on a beautiful user interface, efficient data management through local caching, and a robust, scalable architecture.

Key Features
Stunning UI/UX: A clean, minimalist design that provides a delightful user experience. The app's interface is intuitive and visually appealing, making it easy to check the weather at a glance.

Real-Time Weather Data: Fetches up-to-the-minute weather information from a reliable API, including temperature, humidity, wind speed, and more.

Intelligent Local Caching: To improve performance and reduce data usage, the app intelligently caches weather data locally. This means you can quickly access previously viewed weather information even without an internet connection.

Dynamic Backgrounds: The app's background dynamically changes based on the current weather conditions (e.g., sunny, rainy, cloudy), providing an immersive experience.

Multi-Location Support: Easily search for and save multiple locations to quickly switch between them and check the weather in your favorite cities.

Offline Access: Thanks to local caching, you can view the last fetched weather data for your saved locations even when offline.

Architecture
This project is built using a clean architecture with a three-layered approach to ensure code maintainability, testability, and scalability. This structure separates concerns, making it easier to manage the app's complexity as it grows.

1. Presentation Layer
This is the topmost layer, responsible for everything the user sees and interacts with. It includes the user interface (UI) components and state management. Its primary role is to display data from the business logic layer and handle user input.

2. Domain Layer
The core of the application, this layer contains the business logic and rules. It is completely independent of any frameworks or external dependencies. It defines the app's entities (like a Weather object), use cases (e.g., getWeatherForLocation), and business rules.

3. Data Layer
This layer is responsible for fetching and managing data from various sources, such as a remote API or a local database (for caching). It provides a clean, abstract interface to the domain layer, so the business logic doesn't need to know where the data is coming from.
