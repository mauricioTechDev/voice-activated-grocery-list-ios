import SwiftUI

struct VoiceRecordingButton: View {
    @ObservedObject var viewModel: GroceryListViewModel
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 16) {
            Button(action: {
                viewModel.startRecording()
            }) {
                ZStack {
                    // Base circle
                    Circle()
                        .fill(.clear)
                        .frame(width: 80, height: 80)
                        .glassmorphic(
                            opacity: backgroundOpacity,
                            cornerRadius: 40,
                            borderOpacity: borderOpacity
                        )
                        .shadow(color: shadowColor, radius: 15, x: 0, y: 5)
                    
                    // Icon
                    Image(systemName: iconName)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(iconColor)
                        .scaleEffect(iconScale)
                }
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .scaleEffect(viewModel.recordingState == .recording ? 1.1 : 1.0)
                .rotationEffect(.degrees(viewModel.recordingState == .processing ? 360 : 0))
                .animation(.easeInOut(duration: 0.3), value: isPressed)
                .animation(.easeInOut(duration: 0.3), value: viewModel.recordingState)
                .animation(
                    viewModel.recordingState == .processing
                        ? .linear(duration: 1.0).repeatForever(autoreverses: false)
                        : .default,
                    value: viewModel.recordingState
                )
                .opacity(viewModel.recordingState == .recording ? 0.8 : 1.0)
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: viewModel.recordingState == .recording)
            }
            .disabled(!viewModel.recordingState.isInteractionEnabled)
            .pressEvents {
                isPressed = true
            } onRelease: {
                isPressed = false
            }
            
            // Status text
            Text(viewModel.recordingState.displayText)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
                .animation(.easeInOut(duration: 0.2), value: viewModel.recordingState)
        }
    }
    
    private var backgroundOpacity: Double {
        switch viewModel.recordingState {
        case .idle:
            return 0.2
        case .recording:
            return 0.3
        case .processing:
            return 0.25
        }
    }
    
    private var borderOpacity: Double {
        switch viewModel.recordingState {
        case .idle:
            return 0.3
        case .recording:
            return 0.4
        case .processing:
            return 0.35
        }
    }
    
    private var iconName: String {
        switch viewModel.recordingState {
        case .idle:
            return "mic.fill"
        case .recording:
            return "mic.slash.fill"
        case .processing:
            return "waveform.circle.fill"
        }
    }
    
    private var iconColor: Color {
        switch viewModel.recordingState {
        case .idle:
            return .primary
        case .recording:
            return .red
        case .processing:
            return .blue
        }
    }
    
    private var iconScale: Double {
        viewModel.recordingState == .recording ? 1.1 : 1.0
    }
    
    private var shadowColor: Color {
        switch viewModel.recordingState {
        case .idle:
            return .black.opacity(0.1)
        case .recording:
            return .red.opacity(0.2)
        case .processing:
            return .blue.opacity(0.2)
        }
    }
}

// Custom press events modifier
extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        self.modifier(PressEventsModifier(onPress: onPress, onRelease: onRelease))
    }
}

struct PressEventsModifier: ViewModifier {
    let onPress: () -> Void
    let onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                if pressing {
                    onPress()
                } else {
                    onRelease()
                }
            }, perform: {})
    }
}