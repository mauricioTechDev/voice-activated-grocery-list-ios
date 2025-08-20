import Foundation

struct GroceryItem: Identifiable, Codable {
    let id: String
    let name: String
    let quantity: String?
    var completed: Bool
    
    init(id: String = UUID().uuidString, name: String, quantity: String? = nil, completed: Bool = false) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.completed = completed
    }
}

extension GroceryItem {
    static let sampleItems: [GroceryItem] = [
        GroceryItem(id: "1", name: "Organic Bananas", quantity: "2 lbs", completed: false),
        GroceryItem(id: "2", name: "Whole Milk", quantity: "1 gallon", completed: true),
        GroceryItem(id: "3", name: "Sourdough Bread", completed: false),
        GroceryItem(id: "4", name: "Free-range Eggs", quantity: "1 dozen", completed: false),
        GroceryItem(id: "5", name: "Avocados", quantity: "3 pieces", completed: true),
        GroceryItem(id: "6", name: "Greek Yogurt", quantity: "32 oz", completed: false),
        GroceryItem(id: "7", name: "Chicken Breast", quantity: "2 lbs", completed: false),
        GroceryItem(id: "8", name: "Spinach", quantity: "5 oz bag", completed: false),
        GroceryItem(id: "9", name: "Bell Peppers", quantity: "3 pieces", completed: false),
        GroceryItem(id: "10", name: "Olive Oil", quantity: "500ml", completed: false),
        GroceryItem(id: "11", name: "Quinoa", quantity: "1 lb", completed: false),
        GroceryItem(id: "12", name: "Salmon Fillet", quantity: "1 lb", completed: false)
    ]
}