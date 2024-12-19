//
//  models.swift
//  C4
//
//  Created by Alaa Emad Alhamzi on 17/06/1446 AH.
//

//
//  File.swift
//  challenge4
//
//  Created by Alaa Emad Alhamzi on 17/06/1446 AH.
//

import Foundation
import SwiftData

// MARK: - ChildrenAge Model
@Model
class ChildrenAge {
    var age: Int

    init(age: Int) {
        self.age = age
    }
}

// MARK: - ProgressTracker Model
@Model
class ProgressTracker {
    var completedWords: [Word] = []      // Tracks completed words
    var completedLetters: [Letter] = [] // Tracks completed letters
    var currentLevel: Int = 1           // Current level of progress
    var currentStep: Int = 0            // Current step in the level

    init(completedWords: [Word] = [], completedLetters: [Letter] = [], currentLevel: Int = 1, currentStep: Int = 0) {
        self.completedWords = completedWords
        self.completedLetters = completedLetters
        self.currentLevel = currentLevel
        self.currentStep = currentStep
    }
}

// MARK: - Letter Model
@Model
class Letter {
    var character: String               // The letter itself
    var tutorialVideo: URL?             // Tutorial video for the letter (optional)
    var coloringImages: String          // Path to coloring images for the letter
    var coloringChalkSticks: [String] = [] // List of chalk colors for coloring
    var puzzleImage: String             // Path to puzzle image for the letter
    var puzzlePieces: [String] = []     // List of puzzle piece paths

    init(character: String, tutorialVideo: URL? = nil, coloringImages: String, coloringChalkSticks: [String] = [], puzzleImage: String, puzzlePieces: [String] = []) {
        self.character = character
        self.tutorialVideo = tutorialVideo
        self.coloringImages = coloringImages
        self.coloringChalkSticks = coloringChalkSticks
        self.puzzleImage = puzzleImage
        self.puzzlePieces = puzzlePieces
    }
}

// MARK: - Word Model
@Model
class Word {
    var flashcard: FlashCard             // Flashcard for the word
    var pyramid: [PyramidParts] = []     // Pyramid steps for decoding the word

    init(flashcard: FlashCard, pyramid: [PyramidParts] = []) {
        self.flashcard = flashcard
        self.pyramid = pyramid
    }
}

// MARK: - FlashCard Model
@Model
class FlashCard {
    var text: String                     // Text displayed on the flashcard
    var textBackgroundColor: String      // Background color for the text side
    var imageBackgroundColor: String     // Background color for the image side
    var textColor: String                // Text color

    init(textBackgroundColor: String, imageBackgroundColor: String, textColor: String, text: String) {
        self.textBackgroundColor = textBackgroundColor
        self.imageBackgroundColor = imageBackgroundColor
        self.textColor = textColor
        self.text = text
    }
}

// MARK: - PyramidParts Model
@Model
class PyramidParts {
    var text: String                     // Text for the pyramid part
    var pyramidImage: String             // Path to the image representing the part
    var voiceFile: String                // Path to the voice file for pronunciation

    init(text: String, pyramidImage: String, voiceFile: String) {
        self.text = text
        self.pyramidImage = pyramidImage
        self.voiceFile = voiceFile
    }
}

// MARK: - DragToPyramid Model
@Model
class DragToPyramid {
    var pyramidParts: [PyramidParts]     // Pyramid parts to drag and drop
    var textBoxes: [String]              // Text boxes for drag targets
    var isCorrectPosition: Bool = false // Tracks if the items are correctly positioned

    init(pyramidParts: [PyramidParts], textBoxes: [String], isCorrectPosition: Bool = false) {
        self.pyramidParts = pyramidParts
        self.textBoxes = textBoxes
        self.isCorrectPosition = isCorrectPosition
    }
}
