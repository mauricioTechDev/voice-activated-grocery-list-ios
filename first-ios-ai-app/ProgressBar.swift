import SwiftUI

struct ProgressBar: View {
    let completedCount: Int
    let totalCount: Int
    
    private var percentage: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount) * 100
    }
    
    private var progressWidth: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Shopping Progress")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
            
            HStack {
                Text("\(completedCount) of \(totalCount) items")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("\(Int(percentage.rounded()))% complete")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.green)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                    
                    // Progress fill
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [.green, .green.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: geometry.size.width * progressWidth,
                            height: 8
                        )
                        .animation(.easeInOut(duration: 0.3), value: progressWidth)
                }
            }
            .frame(height: 8)
        }
        .padding(16)
        .glassmorphic(cornerRadius: 16)
    }
}

#Preview {
    VStack(spacing: 20) {
        ProgressBar(completedCount: 0, totalCount: 12)
        ProgressBar(completedCount: 3, totalCount: 12)
        ProgressBar(completedCount: 8, totalCount: 12)
        ProgressBar(completedCount: 12, totalCount: 12)
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