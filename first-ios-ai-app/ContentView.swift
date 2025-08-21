//
//  ContentView.swift
//  first-ios-ai-app
//
//  Created by Mauricio Acosta on 8/9/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GroceryListViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                GlassmorphicBackground()
                
                // Main content
                VStack(spacing: 0) {
                    // Header with safe area
                    VStack(spacing: 24) {
                        // Title
                        VStack(spacing: 8) {
                            Text("Grocery List")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.primary)
                            
                            Text("Voice-activated shopping assistant")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                        }
                        
                        // Voice recording button
                        VoiceRecordingButton(viewModel: viewModel)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 64) // Safe area top
                    .padding(.bottom, 32)
                    
                    // Scrollable content with sticky progress bar
                    ScrollView {
                        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                            Section {
                                LazyVStack(spacing: 12) {
                                    ForEach(viewModel.items) { item in
                                        GroceryListItem(item: item) { id in
                                            print("🏠 ContentView: Received toggle request for id: \(id)")
                                            viewModel.toggleItem(with: id)
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                                .padding(.bottom, 32) // Bottom safe area
                            } header: {
                                // Sticky progress bar
                                VStack {
                                    ProgressBar(
                                        completedCount: viewModel.completedCount,
                                        totalCount: viewModel.totalCount
                                    )
                                    .padding(.horizontal, 24)
                                    .padding(.bottom, 24)
                                    .background(
                                        // Background for sticky header
                                        Rectangle()
                                            .fill(.clear)
                                            .background(.ultraThinMaterial.opacity(0.8))
                                    )
                                }
                            }
                        }
                    }
                    .clipped()
                }
            }
        }
        .frame(maxWidth: 428) // iPhone 16 Pro Max width constraint
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
