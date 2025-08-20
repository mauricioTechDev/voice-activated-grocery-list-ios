import SwiftUI

struct GlassmorphicModifier: ViewModifier {
    let opacity: Double
    let cornerRadius: CGFloat
    let borderOpacity: Double
    
    init(opacity: Double = 0.3, cornerRadius: CGFloat = 16, borderOpacity: Double = 0.4) {
        self.opacity = opacity
        self.cornerRadius = cornerRadius
        self.borderOpacity = borderOpacity
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    // Base glassmorphic background
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                        .background(
                            Color.white.opacity(opacity)
                        )
                    
                    // Gradient overlay
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(borderOpacity), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

extension View {
    func glassmorphic(opacity: Double = 0.3, cornerRadius: CGFloat = 16, borderOpacity: Double = 0.4) -> some View {
        self.modifier(GlassmorphicModifier(opacity: opacity, cornerRadius: cornerRadius, borderOpacity: borderOpacity))
    }
}

// Custom Visual Effect Blur for enhanced glassmorphism
struct VisualEffectBlur: UIViewRepresentable {
    let blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}