//
//  CanvasViewController.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//
//



import SwiftUI
import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}


// ------


struct CanvasView: View {
    @State private var grid: [[String]] = Array(repeating: Array(repeating: "", count: 4), count: 8)  // Initialize grid with empty strings
    @State private var sentence: String = initialSentence()  // Track the sentence as a state variable
    
    var body: some View {
        GeometryReader { geometry in
            let blockWidth = (geometry.size.width+15) / 4  // Block width for 4 columns
            let blockHeight = (geometry.size.height) / 8 // Block height for 8 rows
            
            ZStack {
                Color(hex: "FFFDD3")  // Set background color to FFFDD3
                                    .edgesIgnoringSafeArea(.all)
                                
                // Grid content
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 0) {
                    ForEach(0..<8, id: \.self) { row in
                        ForEach(0..<4, id: \.self) { col in
                            if row < grid.count && col < grid[row].count {
                                BlockView(word: $grid[row][col], backgroundColor:  Color.randomCustomColor())
                                    .frame(width: blockWidth, height: blockHeight)  // Ensuring consistent block sizes
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Generate the grid when the view appears
                grid = generate8x4Grid(from: sentence)
                print("CanvasView appeared on screen")
            }
            .onShake {
                // Update the sentence and regenerate the grid when the device is shaken
                print("onShake called")
                sentence = initialSentence()
                grid = generate8x4Grid(from: sentence)
            }
        }
    }
}

// Helper extension to create Color from hex string
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}



#Preview {
    CanvasView()
}


