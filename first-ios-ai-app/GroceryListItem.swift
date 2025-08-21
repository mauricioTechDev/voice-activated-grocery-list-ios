import SwiftUI

struct GroceryListItem: View {
    let item: GroceryItem
    let onToggle: (String) -> Void
    @GestureState private var isPressed = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Simplified checkbox - make entire item tappable
            ZStack {
                Circle()
                    .fill(checkboxBackgroundColor)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .stroke(checkboxBorderColor, lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                
                if item.completed {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(width: 44, height: 44)
            
            // Item content
            VStack(alignment: .leading, spacing: 2) {
                Text(item.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(item.completed ? .gray : .primary)
                    .strikethrough(item.completed)
                    .animation(.easeInOut(duration: 0.2), value: item.completed)
                
                if let quantity = item.quantity {
                    Text(quantity)
                        .font(.system(size: 14))
                        .foregroundColor(item.completed ? Color.gray.opacity(0.6) : .secondary)
                        .animation(.easeInOut(duration: 0.2), value: item.completed)
                }
            }
            
            Spacer()
        }
        .padding(16)
        .glassmorphic(
            opacity: item.completed ? 0.4 : 0.3,
            cornerRadius: 16,
            borderOpacity: item.completed ? 0.3 : 0.4
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .fill(item.completed ? Color.green.opacity(0.1) : Color.clear)
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .contentShape(Rectangle()) // Make entire area tappable
        .onTapGesture {
            print("🚨 ENTIRE ROW TAPPED - Item: \(item.name), current state: \(item.completed)")
            withAnimation(.easeInOut(duration: 0.2)) {
                onToggle(item.id)
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
        )
    }
    
    private var checkboxBackgroundColor: Color {
        if item.completed {
            return .green
        } else {
            return Color.white.opacity(0.4)
        }
    }
    
    private var checkboxBorderColor: Color {
        if item.completed {
            return .green
        } else {
            return Color.gray.opacity(0.3)
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        GroceryListItem(
            item: GroceryItem(name: "Organic Bananas", quantity: "2 lbs", completed: false),
            onToggle: { _ in }
        )
        
        GroceryListItem(
            item: GroceryItem(name: "Whole Milk", quantity: "1 gallon", completed: true),
            onToggle: { _ in }
        )
        
        GroceryListItem(
            item: GroceryItem(name: "Sourdough Bread", completed: false),
            onToggle: { _ in }
        )
    }
    .padding()
    .background(
        LinearGradient(
            colors: [.blue.opacity(0.1), .white, .purple.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
}