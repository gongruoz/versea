//
//  ContentView.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//

//import SwiftUI
//
//struct ContentView: View {
//    let message = "I look forward to seeing you again soon"
//    let gridItems = Array(repeating: GridItem(.flexible(), spacing: 5), count: 4)
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Versea")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .foregroundColor(.blue)
//            
//            LazyVGrid(columns: gridItems, spacing: 5) {
//                ForEach(message.components(separatedBy: " "), id: \.self) { word in
//                    Text(word)
//                        .font(.system(size: 14, weight: .semibold))
//                        .foregroundColor(.white)
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
//                        .background(Color.blue.opacity(Double.random(in: 0.3...1)))
//                        .cornerRadius(8)
//                }
//                
//                ForEach(0..<8) { _ in
//                    Rectangle()
//                        .fill(Color.blue.opacity(Double.random(in: 0.1...0.5)))
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
//                        .cornerRadius(8)
//                }
//            
//            }
//            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 16)
//                    .stroke(Color.blue, lineWidth: 2)
//            )
//            .padding()
//        }
//    }
//}
//
//
//
//#Preview {
//    ContentView()
//}
