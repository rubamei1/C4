//
//  FlashcardView.swift
//  C4
//
//  Created by Ruba Meshal Alqahtani on 18/12/2024.
//
import SwiftUI
import SwiftData

struct FlashcardView: View {
    // Fetch Words with their associated FlashCards
    @Query var words: [Word]
    
    // Track the current index of flashcards
    @State private var currentIndex: Int = 0
    
    // Computed property to get the current flashcard
    private var currentFlashcard: FlashCard? {
        guard words.indices.contains(currentIndex) else { return nil }
        return words[currentIndex].flashcard
    }
    
    var body: some View {
        ZStack {
            // Background
            Color.yellow.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Progress Bar
                progressBar
                
                Spacer()
                
                // Flashcard Content
                if let flashcard = currentFlashcard {
                    flashcardContent(flashcard: flashcard)
                } else {
                    Text("No Flashcards Available")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
            
            // Bottom Button (Centered at Bottom)
            bottomButton
            
            // Character Image (Fixed Position)
            bottomLeftCharacterImage
        }
    }
    
    // MARK: - Progress Bar
    private var progressBar: some View {
        HStack {
            ForEach(0..<words.count, id: \.self) { index in
                Circle()
                    .fill(index <= currentIndex ? Color.orange : Color.gray.opacity(0.4))
                    .frame(width: 15, height: 15)
            }
        }
        .padding(.top)
    }
    
    // MARK: - Flashcard Content
    private func flashcardContent(flashcard: FlashCard) -> some View {
        HStack {
            // Left Side: Image
            ZStack {
                Color(from: flashcard.imageBackgroundColor) // Map string to color
                    .opacity(1.0) // Ensure background visibility
                Image("GrayRabbit") // Replace with your image name
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            .frame(width: 250, height: 350)
            .cornerRadius(10)
            
            // Right Side: Text
            ZStack {
                Color("TextBackground") // Map string to color
                    .opacity(1.0) // Ensure background visibility
                Text(flashcard.text)
                    .font(.largeTitle)
                    .foregroundColor(Color(from: flashcard.textColor)) // Text color
                    .bold()
            }
            .frame(width: 250, height: 350)
            .cornerRadius(10)
            .overlay(
                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(.black)
                    .padding(),
                alignment: .topTrailing
            )
        }
    }
    
    // MARK: - Bottom Button (Centered at Bottom)
    private var bottomButton: some View {
        VStack {
            Spacer()
            Button(action: {
                if currentIndex < words.count - 1 {
                    currentIndex += 1
                }
            }) {
                Image(systemName: "arrow.left.circle.fill")
                    .font(.system(size: 70)) // Adjusted size
                    .foregroundColor(.yellow)
            }
            .frame(width: 150, height: 150)
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 120) // Centered at bottom
        }
    }
    
    // MARK: - Bottom-Left Character Image
    private var bottomLeftCharacterImage: some View {
        Image("Character") // Replace with your image name
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .position(x: 120, y: 670)
    }
}

#Preview {
    // Sample Data for Preview
    let sampleFlashCard = FlashCard(
        textBackgroundColor: "pink",     // Background color of the text side
        imageBackgroundColor: "white",  // Background color of the image side
        textColor: "black",              // Text color
        text: "أرنب"                     // Text on the flashcard
    )
    
    let sampleWord = Word(flashcard: sampleFlashCard, pyramid: [])
    
    let previewContainer = try! ModelContainer(for: Word.self, FlashCard.self)
    try! previewContainer.mainContext.insert(sampleWord)
    
    return FlashcardView()
        .modelContainer(previewContainer)
}
