import SwiftUI

struct ContentView: View {
    @State private var startPoint: CGPoint? = nil // Начальная точка выделения
    @State private var currentPoint: CGPoint? = nil // Текущая точка выделения (при движении мыши)
    @State private var squares: [CGRect] = [] // Массив для хранения координат квадратиков
    @State private var selectedSquares: Set<CGRect> = [] // Выделенные квадратики
    @State private var offset: CGSize = .zero // Смещение для перетаскивания квадратиков

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // Основная интерактивная область
                    Color.green.opacity(0.2)
                        .gesture(
                            DragGesture(minimumDistance: 0) // Перетаскивание для выделения
                                .onChanged { value in
                                    if startPoint == nil {
                                        startPoint = value.startLocation // Установка начальной точки выделения
                                    }
                                    currentPoint = value.location // Обновление текущей точки
                                    updateSelectedSquares() // Обновление выделенных квадратиков
                                }
                                .onEnded { _ in
                                    startPoint = nil
                                    currentPoint = nil
                                }
                        )
                    
                    // Рисование квадратиков
                    ForEach(squares, id: \.self) { square in
                        Rectangle()
                            .fill(selectedSquares.contains(square) ? Color.red : Color.blue) // Изменение цвета, если выделено
                            .frame(width: square.width, height: square.height)
                            .position(x: square.midX + (selectedSquares.contains(square) ? offset.width : 0),
                                      y: square.midY + (selectedSquares.contains(square) ? offset.height : 0))
                    }
                    
                    // Рисование прямоугольника выделения
                    if let start = startPoint, let current = currentPoint {
                        Path { path in
                            path.addRect(CGRect(
                                x: min(start.x, current.x),
                                y: min(start.y, current.y),
                                width: abs(current.x - start.x),
                                height: abs(current.y - start.y)
                            ))
                        }
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [6])) // Пунктирная рамка
                        .foregroundColor(.blue)
                    }
                }
                .gesture(
                    DragGesture() // Перетаскивание выделенных объектов
                        .onChanged { value in
                            if !selectedSquares.isEmpty {
                                offset = value.translation // Изменение смещения
                            }
                        }
                        .onEnded { value in
                            moveSelectedSquares(by: value.translation) // Обновление позиций
                            offset = .zero
                        }
                )
                .onAppear {
                    generateRandomSquares(in: geometry.size) // Генерация случайных квадратиков
                }
            }
        }
    }
    
    // Генерация случайных квадратиков
    private func generateRandomSquares(in size: CGSize) {
        squares = (1...20).map { _ in
            let side: CGFloat = 30 // Размер квадрата
            let x = CGFloat.random(in: 0...(size.width - side))
            let y = CGFloat.random(in: 0...(size.height - side))
            return CGRect(x: x, y: y, width: side, height: side)
        }
    }
    
    // Обновление выделенных квадратиков
    private func updateSelectedSquares() {
        guard let start = startPoint, let current = currentPoint else { return }
        let selectionRect = CGRect(
            x: min(start.x, current.x),
            y: min(start.y, current.y),
            width: abs(current.x - start.x),
            height: abs(current.y - start.y)
        )
        selectedSquares = Set(squares.filter { $0.intersects(selectionRect) }) // Проверка пересечения с выделением
    }
    
    // Перемещение выделенных квадратиков
    private func moveSelectedSquares(by translation: CGSize) {
        let updatedSquares = squares.map { square -> CGRect in
            if selectedSquares.contains(square) {
                let newSquare = CGRect(
                    x: square.origin.x + translation.width,
                    y: square.origin.y + translation.height,
                    width: square.width,
                    height: square.height
                )
                selectedSquares.remove(square)
                selectedSquares.insert(newSquare)
                return newSquare
            }
            return square
        }
        squares = updatedSquares // Обновление позиций квадратиков
    }
}

#Preview {
    ContentView()
}
