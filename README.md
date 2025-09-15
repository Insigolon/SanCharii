# SanChari

SanChari is a **real-time bus tracking and route management app** built with Flutter.  
It allows passengers to search for routes, view bus locations, and see previously taken buses — while conductors can log in, update their route information, and manage bus stops in real time.

---
# Features

### Passenger Features
- **Interactive Map** – Displays available buses and routes based on your start location and destination.
- **Smart Search** – Choose start location manually if location permission is not granted.
- **Previous Buses Taken** – Quick access to recently taken bus routes (e.g., MF21, 25B).
- **Smooth UI** – Draggable bottom sheet, clean design, and easy navigation.
- **Offline Friendly** – Map and route search still work with manual input if GPS is disabled.

###  Conductor Features
- **Conductor Info Setup** – Enter route number and conductor name/ID (saved to Firestore).
- **Dashboard** – View and edit:
  - Route number
  - Start and destination points
  - List of stops (add/remove dynamically)
- **Secure Auth** – Integrated with Firebase Authentication.
- **Persistent Data** – All conductor data is stored in Firestore so it stays synced across devices.

---

##  Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase Firestore + Firebase Auth
- **Maps:** Google Maps SDK
- **State Management:** Flutter's built-in `StatefulWidget` (can be upgraded to Provider/Bloc if needed)


## 🔧 Installation & Setup

1. **Clone this repository**
   ```bash
   git clone https://github.com/your-username/SanChari.git
   cd SanChari
