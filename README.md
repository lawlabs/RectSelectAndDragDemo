# SwiftUI Rectangle Selection and Object Manipulation

This project demonstrates a simple SwiftUI-based application for selecting and manipulating objects (squares). It's designed as an educational resource, showcasing how to implement key features like rectangle selection, dragging, and updating object states dynamically.

## Features
1. **Rectangle Selection**: Click and drag to draw a selection rectangle. Any squares intersecting the rectangle are highlighted.
2. **Drag-and-Drop**: Selected squares can be dragged to a new position by holding and moving the mouse.
3. **Dynamic Updates**: The positions of squares update in real-time during drag-and-drop interactions.
4. **Interactive Feedback**: Squares change color to indicate their selection status.

## How to Use
1. Clone the repository and run the project in Xcode.
2. Drag within the green area to select squares.
3. Drag the selected squares to move them.

## Demo Screenshots
### Initial State

<img width="973" alt="image" src="https://github.com/user-attachments/assets/434339ff-75b4-426b-adf3-2d472d1e8b3e">

### Rectangle Selection

<img width="973" alt="Снимок экрана 2024-11-29 в 11 31 05" src="https://github.com/user-attachments/assets/a0ace3d2-9f5f-4837-a77f-9983137a1b68">


### Drag-and-Drop

https://github.com/user-attachments/assets/04fb861b-2b64-46bb-afac-224776f9d2c1



## Code Overview
- **`ContentView.swift`**: Contains all logic for selection and manipulation.
- **`generateRandomSquares`**: Randomly generates square positions.
- **`updateSelectedSquares`**: Updates the selection status of squares based on their intersection with the selection rectangle.
- **`moveSelectedSquares`**: Updates the positions of selected squares after a drag operation.

## Prerequisites
- Xcode 14 or later
- macOS 13 or later

## Contributions
Feel free to fork this repository, submit pull requests, or suggest improvements!
