import Foundation

struct DataManager {
    static let sharedDataManager = DataManager()
    
    private var items = [
        "todo": [
            "Buy groceries",
            "Finish homework",
            "Call mom",
            "Go for a run",
            "Read a book"
        ],
        "archived": [
            "Write code for project",
            "Pay bills",
            "Clean the house",
            "Schedule dentist appointment",
            "Plan weekend activities"
        ]
    ]
    
    func fetchItems() -> [String: [String]] {
        return self.items
    }
}
