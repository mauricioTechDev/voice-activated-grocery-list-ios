import Foundation
import Combine
import UIKit

class GroceryListViewModel: ObservableObject {
    @Published var items: [GroceryItem] = GroceryItem.sampleItems
    @Published var recordingState: RecordingState = .idle
    
    var completedCount: Int {
        items.filter(\.completed).count
    }
    
    var totalCount: Int {
        items.count
    }
    
    var completionPercentage: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount) * 100
    }
    
    func toggleItem(with id: String) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { 
            print("❌ Could not find item with id: \(id)")
            return 
        }
        
        let oldState = items[index].completed
        
        // Create a new copy of the item with toggled state
        var updatedItem = items[index]
        updatedItem.completed.toggle()
        
        print("✅ Toggling '\(updatedItem.name)': \(oldState) → \(updatedItem.completed)")
        
        // Replace the item in the array to ensure SwiftUI detects the change
        items[index] = updatedItem
        
        // Add haptic feedback for better user experience
        if updatedItem.completed {
            // Item was completed - use impact feedback
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.prepare()
            impactFeedback.impactOccurred()
        } else {
            // Item was uncompleted - use selection feedback
            let selectionFeedback = UISelectionFeedbackGenerator()
            selectionFeedback.prepare()
            selectionFeedback.selectionChanged()
        }
        
        // Force update by explicitly calling objectWillChange if needed
        objectWillChange.send()
        
        print("📊 Progress: \(completedCount)/\(totalCount) (\(Int(completionPercentage))%)")
    }
    
    func startRecording() {
        guard recordingState == .idle else { return }
        
        recordingState = .recording
        
        // Simulate recording for 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.recordingState = .processing
            
            // Simulate processing for 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.recordingState = .idle
                // Here you would add new items from voice recognition
                self.simulateAddingItem()
            }
        }
    }
    
    private func simulateAddingItem() {
        let newItems = [
            "Fresh Strawberries",
            "Coconut Water",
            "Dark Chocolate",
            "Almonds",
            "Honey"
        ]
        
        if let randomItem = newItems.randomElement() {
            let newGroceryItem = GroceryItem(name: randomItem, quantity: nil, completed: false)
            items.append(newGroceryItem)
        }
    }
    
    func addItem(_ item: GroceryItem) {
        items.append(item)
    }
    
    func removeItem(with id: String) {
        items.removeAll { $0.id == id }
    }
}