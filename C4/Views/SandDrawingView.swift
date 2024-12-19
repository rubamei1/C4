//
//  SandDrawingView.swift
//  C4
//
//  Created by Alaa Emad Alhamzi on 18/06/1446 AH.
//

import SwiftUI
import AVFoundation

// MARK: - Model
struct SandStroke: Identifiable {
    let id = UUID()
    let points: [CGPoint]
    let isErasing: Bool // Determines if the stroke is for erasing
}

// MARK: - ViewModel
class SandDrawingViewModel: ObservableObject {
    @Published var strokes: [SandStroke] = []
    private var currentStroke: [CGPoint] = []
    private var sandSoundPlayer: AVAudioPlayer?
    
    init() {
        loadSandSound()
    }
    
    // Load sand sound effect
    func loadSandSound() {
        if let url = Bundle.main.url(forResource: "sand_sound", withExtension: "mp3") {
            do {
                sandSoundPlayer = try AVAudioPlayer(contentsOf: url)
                sandSoundPlayer?.prepareToPlay()
            } catch {
                print("Error loading sand sound: \(error.localizedDescription)")
            }
        }
    }
    
    // Start a new stroke
    func startStroke(at point: CGPoint, isErasing: Bool) {
        currentStroke = [point]
        playSandSound()
    }
    
    // Continue the stroke
    func continueStroke(to point: CGPoint) {
        currentStroke.append(point)
    }
    
    // Finish the stroke and save it
    func endStroke(isErasing: Bool) {
        if !currentStroke.isEmpty {
            let newStroke = SandStroke(points: currentStroke, isErasing: isErasing)
            strokes.append(newStroke)
            currentStroke = []
        }
        stopSandSound()
    }
    
    // Play sand sound
    private func playSandSound() {
        sandSoundPlayer?.play()
    }
    
    // Stop sand sound
    private func stopSandSound() {
        sandSoundPlayer?.stop()
    }
    
    // Clear all strokes
    func clearCanvas() {
        strokes.removeAll()
    }
}



// MARK: - SandDrawingView
struct SandDrawingView: View {
    @StateObject private var viewModel = SandDrawingViewModel()
    @State private var isWritingEnabled: Bool = true // Toggle writing mode
    @State private var isErasingEnabled: Bool = false // Toggle erasing mode
    @State private var currentLevel: Int = 1 // User's current progress level
    
    var body: some View {
        ZStack {
            // Background color
            Color("InterfacesColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()

                // Progress bar in the middle
                ProgressBarView(currentLevel: currentLevel)
                    .frame(width: 400, height: 60)
                
                // Text below the progress bar
                Text("ارنب")
                    .font(.system(size: 70))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack {
                    // Buttons next to the sand rectangle
                    VStack(spacing: 20) {
                        Button(action: {
                            isWritingEnabled = true
                            isErasingEnabled = false
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(isWritingEnabled ? .orange : .gray)
                        }
                        
                        Button(action: {
                            isWritingEnabled = false
                            isErasingEnabled = true
                        }) {
                            Image(systemName: "eraser.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(isErasingEnabled ? .orange : .gray)
                        }
                    }
                    .padding(.trailing, 20)
                    
                    // Sand Drawing Area
                    ZStack {
                        // Sand background
                        Image("sand_texture")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 952, height: 476)
                            .clipped()
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        
                        // Strokes with 3D effect
                        ForEach(viewModel.strokes) { stroke in
                            if stroke.isErasing {
                                Path { path in
                                    guard let firstPoint = stroke.points.first else { return }
                                    path.move(to: firstPoint)
                                    stroke.points.forEach { point in
                                        path.addLine(to: point)
                                    }
                                }
                                .stroke(Color("background"), lineWidth: 20)
                            } else {
                                Path { path in
                                    guard let firstPoint = stroke.points.first else { return }
                                    path.move(to: firstPoint)
                                    stroke.points.forEach { point in
                                        path.addLine(to: point)
                                    }
                                }
                                .stroke(Color.black.opacity(0.3), lineWidth: 6)
                                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 2, y: 2)
                                .blendMode(.multiply)
                                
                                Path { path in
                                    guard let firstPoint = stroke.points.first else { return }
                                    path.move(to: firstPoint)
                                    stroke.points.forEach { point in
                                        path.addLine(to: point)
                                    }
                                }
                                .stroke(Color.white.opacity(0.6), lineWidth: 3)
                                .offset(x: -1, y: -1)
                                .blendMode(.overlay)
                            }
                        }
                        
                        // Gesture area
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 952, height: 476)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        if isErasingEnabled {
                                            viewModel.startStroke(at: value.location, isErasing: true)
                                        } else {
                                            viewModel.startStroke(at: value.location, isErasing: false)
                                        }
                                        viewModel.continueStroke(to: value.location)
                                    }
                                    .onEnded { _ in
                                        viewModel.endStroke(isErasing: isErasingEnabled)
                                    }
                            )
                    }
                }
                
                Spacer()
                
                // Checkmark button in the body
                Button(action: {
                    print("Check button tapped")
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.orange)
                        .padding()
                }
            }
        }
    }
}

// MARK: - Preview
struct SandDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        SandDrawingView()
    }
}
