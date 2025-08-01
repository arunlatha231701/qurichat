# ChatApp

A Flutter-based chat application that connects customers with vendors, featuring role-based authentication, real-time messaging, and an intuitive UI.

## Features

- **Role-based Authentication**: Users can sign in as either Customers or Vendors
- **Real-time Chat**: Send and receive messages instantly
- **Beautiful UI**: Animated transitions and gradient designs
- **Search Functionality**: Easily find specific chats
- **Responsive Design**: Works on various screen sizes
- **State Management**: Uses BLoC pattern for efficient state handling

## Screens
![chat_list_screen.jpeg](assets/screenshots/chat_list_screen.jpeg)
![chat_screen.jpeg](assets/screenshots/chat_screen.jpeg)
![login_screen.jpeg](assets/screenshots/login_screen.jpeg)
![search_screen.jpeg](assets/screenshots/search_screen.jpeg)
![users_screen.jpeg](assets/screenshots/users_screen.jpeg)

1. **Role Selection View**
    - Choose between Customer or Vendor roles
    - Animated welcome screen with gradient background

2. **Login View**
    - Email and password authentication
    - Form validation
    - Loading states during authentication

3. **Chat List View**
    - List of all conversations
    - Search functionality
    - Pull-to-refresh
    - Logout option

4. **Chat Detail View**
    - Real-time message exchange
    - Typing indicators
    - Message bubbles with timestamps
    - Smooth scrolling to new messages

## Technical Stack

- **Frontend**: Flutter
- **State Management**: Flutter BLoC
- **UI Components**: Custom widgets with animations
- **Dependency Injection**: Provider package
- **Styling**: Custom themes and constants

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- IDE (Android Studio, VS Code, etc.)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/arunlatha231701/qurichat.git
