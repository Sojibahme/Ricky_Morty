# Rick and Morty Wiki App

## Overview
Welcome to the Rick and Morty Wiki App! This Flutter application serves as a platform for exploring information about the beloved characters from the Rick and Morty universe. The app utilizes the Rick and Morty API as its backend to fetch character data and display it in an intuitive manner.

## Features
- **Splash Screen**: A visually appealing splash screen greets users upon launching the app, setting the tone for the Rick and Morty experience.
- **Firebase Google Auth Screen**: Authentication using firebase google sign in method.
- **All Cast Screen**: Displays a paginated list of Rick and Morty characters fetched from the GraphQL API. Users can scroll through the list to discover their favorite characters.
- **Cast Details Screen**: Provides detailed information about a selected character, including their name, status, species, origin, and more.
- **State Management**: Implements state management using the Bloc pattern to efficiently manage application state and data flow.
- **HTTP Requests**: Fetches character data from the Rick and Morty GraphQL API using HTTP requests. The app utilizes either the dio or http package for this purpose.
- **Design Pattern Implementation**: Demonstrates the use of design patterns to promote code modularity and reusability, enhancing the maintainability of the application.
- **Material Icons**: Integrates Material Icons to enhance the visual appeal and consistency of the app's user interface.

## Installation
To run the Rick and Morty Wiki App on your local machine, follow these steps:

1. Clone this repository to your local environment using the following command:
   ```bash
   git clone https://github.com/Sojibahme/Ricky_Morty.git
Navigate to the project directory:

Copy code
cd rick-and-morty
Install dependencies by running:

Copy code
flutter pub get
Launch the app on an emulator or physical device.

Demo
A demo of the Rick and Morty App is available for viewing. You can access the deployed app via the following link: APK File.

Project Structure
The project follows a structured organization to maintain code cleanliness and readability:

   ```bash
├───data
│   ├───graphql
│   ├───models
│   └───repositories
├───domain
│   ├───entities
│   └───repositories
├───presentation
│   ├───blocs
│   │   ├───character
│   │   └───navigation
│   ├───screens
│   └───widgets
├───services
└───utils

