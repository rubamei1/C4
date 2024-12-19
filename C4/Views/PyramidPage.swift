//
//  PyramidPage.swift
//  C4
//
//  Created by Alaa Emad Alhamzi on 18/06/1446 AH.
//

import SwiftUI

struct PyramidPage: View {
    @State private var isLevelOne = true
    @State private var pyramidParts: [PyramidParts] = [
        PyramidParts(text: "أ", pyramidImage: "Vector 200", voiceFile: "sound1"),
        PyramidParts(text: "أر", pyramidImage: "Vector 201", voiceFile: "sound2"),
        PyramidParts(text: "أرن", pyramidImage: "Vector 202", voiceFile: "sound3"),
        PyramidParts(text: "أرنب", pyramidImage: "Vector 203", voiceFile: "sound4")
    ]
    
        @State private var stickyNotes: [String] = ["أ", "أر", "أرن", "أرنب"]
        @State private var positions: [CGSize] = [CGSize.zero, CGSize.zero, CGSize.zero, CGSize.zero]
        @State private var targetPositions: [CGRect] = Array(repeating: CGRect.zero, count: 4)
    

    var body: some View {
        NavigationStack {
            ZStack {
                Color("InterfacesColor").ignoresSafeArea(.all)
                
                VStack(spacing: 90) {
                    // Progress Bar
                    ProgressBarView(currentLevel: isLevelOne ? 1 : 2)
                    
                    // Pyramid View
                    VStack(spacing: -10) {
                        ForEach(0..<pyramidParts.count, id: \.self) { index in
                            PyramidPartView(part: pyramidParts[index], isLevelOne: isLevelOne)
                        }
                    }
                    
                    // Navigation to the second view
                    NavigationLink(destination: PyramidView(pyramidParts: pyramidParts, isLevelOne: !isLevelOne)) {
                        Image(systemName: "arrow.backward.circle")
                            .resizable()
                            .foregroundStyle(Color.orange)
                            .frame(width: 78, height: 78)
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
    }
}




struct PyramidView: View {
    var pyramidParts: [PyramidParts]
    var isLevelOne: Bool
    
    @State private var stickyNotes: [String] = ["أ", "أر", "أرن", "أرنب"]
    @State private var positions: [CGSize] = [CGSize.zero, CGSize.zero, CGSize.zero, CGSize.zero]
    @State private var targetPositions: [CGRect] = Array(repeating: CGRect.zero, count: 4)

    var body: some View {
        
        
        ZStack {
            Color.yellow.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 90) {
                // Progress Bar
                ProgressBarView(currentLevel: isLevelOne ? 1 : 2)
                
                HStack{
                    // Pyramid Images
                     VStack(spacing: -10) {
                        ForEach(0..<pyramidParts.count, id: \.self) { index in
                        // Show only the image in the second view
                         PyramidPartView(part: pyramidParts[index], isLevelOne: false)
                       }
           }
                    
                    
                        
                        ZStack{
                            Spacer()
                            Rectangle().fill(Color("OrangeBox")).frame(width: 140, height: 400).cornerRadius(20)
                                                
                                                
                            VStack(spacing:8){
                                ForEach(Array(stickyNotes.enumerated()), id: \.offset) { index, text in
                                    Text(text)
                                        .font(.title)
                                        .frame(width: 100, height: 80)
                                        .background(Color("Bige"))
                                        .cornerRadius(8)
                                        //.shadow(radius: 3)
                                        .offset(positions[index])
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    positions[index] = value.translation
                                                }
                                                .onEnded { value in
                                                    checkDropPosition(index: index)
                                                }
                                        )
                                }
                            }
                        }
                    
                        
                        
                    
                    
                }
                
                
                // Navigation to the next view
                NavigationLink(destination: PyramidView(pyramidParts: pyramidParts, isLevelOne: !isLevelOne)) {
                    Image(systemName: "arrow.backward.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
private func checkDropPosition(index: Int) {
        for i in 0..<targetPositions.count {
            if targetPositions[i].contains(CGPoint(x: positions[index].width, y: positions[index].height)) {
                print("Correct position for \(stickyNotes[index])")
                // Snap to target position
                positions[index] = CGSize(width: targetPositions[i].origin.x, height: targetPositions[i].origin.y)
                break
            }
        }
    }

}

struct ProgressBarView: View {
    var currentLevel: Int // Indicates the user's progress (1 = first pumpkin, 2 = second pumpkin, etc.)

    var body: some View {
        ZStack(alignment: .trailing) { // Align everything to the trailing edge (right side)
            // Background gray bar
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 400, height: 30)
                .cornerRadius(55)
            
            if currentLevel == 2{
                // Orange progress bar filling from the right
                           Rectangle()
                    .fill(Color("Bar"))
                               .frame(width: CGFloat(currentLevel) * 75, height: 30)
                               .cornerRadius(55)
                               .animation(.easeInOut, value: currentLevel)
            }
           

            // Pumpkins overlay
            HStack(spacing: 75) {
                ForEach(0..<4) { index in
                    
                            Image("pumpkin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 55)
                        
                }
                
            }.padding(.horizontal,-15)
        }
        .frame(width: 400, alignment: .trailing) // Ensure the progress bar aligns to the right
    }
}



struct PyramidPartView: View {
    var part: PyramidParts
    var isLevelOne: Bool

    var body: some View {
        ZStack {
            Image(part.pyramidImage)
                .resizable()
                .scaledToFit()
                .frame(height: 80)

            // Conditionally display text
            if isLevelOne {
                Text(part.text)
                    .font(.title)
                    .foregroundColor(.black)
            }
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PyramidPage()
    }
}
