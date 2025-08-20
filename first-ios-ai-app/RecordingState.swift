import Foundation

enum RecordingState: CaseIterable {
    case idle
    case recording
    case processing
    
    var displayText: String {
        switch self {
        case .idle:
            return "Tap to add items"
        case .recording:
            return "Listening..."
        case .processing:
            return "Processing..."
        }
    }
    
    var isInteractionEnabled: Bool {
        self == .idle
    }
}