//
//  ContentView.swift
//  Summary
//
//  Created by Kouv on 23/02/2025.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel = SummaryViewModel()
    @State private var showLoading = false
    @State private var showCallButton = false
    @State private var hideFetchButton = false
    private var customPurple = UIColor(red: 98, green: 56, blue: 203, alpha: 1.0)
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.purple]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Text(viewModel.summaryText)
                        .font(!hideFetchButton ? .title:.headline)
                        .padding()
                    
                    if !hideFetchButton {
                        Button {
                            Task {
                                showLoading = true
                                do {
                                    try await viewModel.getSummary() {_ in
                                        showLoading = false
                                        hideFetchButton = true
                                        showCallButton = true
                                    }
                                } catch {
                                    print("Failed to fetch account info \(error.localizedDescription)")
                                    hideFetchButton = false
                                    showLoading = false

                                }
                            }
                        } label: {
                            if showLoading {
                                ProgressView("Fetching")
                                    .tint(.white)
                                    .foregroundStyle(.white)
                            } else {
                                Text("Fetch Account info")
                                
                                
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.purple)
                }
                
                }
               
                Spacer()
            }
            .padding()
            .navigationTitle("Summarize")
            .toolbar {
                if showCallButton {
                    Button {
                        viewModel.callWithSummary()
                    }label: {
                        Image(systemName: "phone")
                        Text("Inform")
                            .font(.headline)
                    }
                }
                
            }
        }
       
    }
    
}

#Preview {
    ContentView()
}
