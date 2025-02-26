# Character Details App

This Flutter app provides detailed information about various characters, including their basic details, homeworld, and films they appeared in. It fetches data from an external API, and presents it in a clean, responsive layout. The app utilizes the **GetX** package for state management and **Obx** for real-time updates.

## Features

- **Character Information**: View details like name, height, mass, birth year, and gender.
- **Homeworld Information**: Fetches and displays the homeworld dynamically.
- **Films**: Displays a list of films in which the character appeared.
- **Responsive UI**: Supports both mobile and web applications.
- **Beautiful UI Design**: Modern card design with smooth transitions.

## Screenshots

![Screenshot 1](lib/assets/screenshot1.png)
![Screenshot 2](lib/assets/screenshot2.png)
![Screenshot 2](lib/assets/screenshot3.png)

## Technologies Used

- **Flutter**: The framework used to build this cross-platform app.
- **GetX**: For state management and efficient data binding.
- **CustomColor**: For a beautiful, modern color scheme.
- **API Integration**: Fetching character data and displaying it dynamically.

## Installation

### Prerequisites

Make sure you have the following installed:
- Flutter SDK (Latest stable version)
- Dart SDK
- A code editor like VS Code or Android Studio

### Steps to Run the App

1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/majidbhuiyan20/Star-Wars-App.git
    ```

2. Navigate into the project directory:
    ```bash
    cd character-details-app
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app:
    ```bash
    flutter run
    ```

   For web:
    ```bash
    flutter run -d chrome
    ```

## Usage

- Once you launch the app, you'll be presented with a list of characters.
- Select a character to view detailed information like name, height, mass, and films.
- Data such as homeworld and films are fetched dynamically from an API.
- The layout is responsive and adjusts for both mobile and web.

## Directory Structure

