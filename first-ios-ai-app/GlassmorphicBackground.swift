import SwiftUI

struct GlassmorphicBackground: View {
    var body: some View {
        ZStack {
            // Main gradient background
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.1),
                    Color.white,
                    Color.purple.opacity(0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Radial gradient overlays
            RadialGradientOverlay()
            
            // iOS-style backdrop blur overlays
            BackdropBlurOverlay()
        }
        .ignoresSafeArea()
    }
}

struct RadialGradientOverlay: View {
    var body: some View {
        ZStack {
            // Center radial gradient
            RadialGradient(
                colors: [
                    Color(red: 120/255, green: 119/255, blue: 198/255).opacity(0.1),
                    Color.clear
                ],
                center: .center,
                startRadius: 0,
                endRadius: 300
            )
            
            // Top-right radial gradient
            RadialGradient(
                colors: [
                    Color.blue.opacity(0.1),
                    Color.clear
                ],
                center: UnitPoint(x: 1.0, y: 0.25),
                startRadius: 0,
                endRadius: 200
            )
            
            // Bottom-left radial gradient
            RadialGradient(
                colors: [
                    Color.purple.opacity(0.1),
                    Color.clear
                ],
                center: UnitPoint(x: 0.0, y: 0.75),
                startRadius: 0,
                endRadius: 150
            )
        }
        .opacity(0.3)
    }
}

struct BackdropBlurOverlay: View {
    var body: some View {
        VStack {
            // Top blur overlay
            LinearGradient(
                colors: [
                    Color.white.opacity(0.2),
                    Color.clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 120)
            .background(.ultraThinMaterial.opacity(0.5))
            
            Spacer()
            
            // Bottom blur overlay
            LinearGradient(
                colors: [
                    Color.clear,
                    Color.white.opacity(0.2)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 120)
            .background(.ultraThinMaterial.opacity(0.5))
        }
    }
}

#Preview {
    GlassmorphicBackground()
}