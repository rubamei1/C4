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

@Model
class ChildrenAge {
    var age: Int

    init(age: Int) {
        self.age = age
    }
}

@Model
class ProgressTracker {
    var completedWords: [Word] = []
    var completedLetters: [Letter] = []
    var currentLevel: Int = 1
    var currentStep: Int = 0

    init(completedWords: [Word] = [], completedLetters: [Letter] = [], currentLevel: Int = 1, currentStep: Int = 0) {
        self.completedWords = completedWords
        self.completedLetters = completedLetters
        self.currentLevel = currentLevel
        self.currentStep = currentStep
    }
}

@Model
class Letter {
    var character: String
    var tutorialVideo: URL?
    var coloringImages: String
    var coloringChalkSticks: [String] = []
    var puzzleImage: String
    var puzzlePieces: [String] = []

    init(character: String, tutorialVideo: URL? = nil, coloringImages: String, coloringChalkSticks: [String] = [], puzzleImage: String, puzzlePieces: [String] = []) {
        self.character = character
        self.tutorialVideo = tutorialVideo
        self.coloringImages = coloringImages
        self.coloringChalkSticks = coloringChalkSticks
        self.puzzleImage = puzzleImage
        self.puzzlePieces = puzzlePieces
    }
}

@Model
class Word {
    var flashcard: FlashCard
    var pyramid: [PyramidParts] = []

    init(flashcard: FlashCard, pyramid: [PyramidParts] = []) {
        self.flashcard = flashcard
        self.pyramid = pyramid
    }
}

@Model
class FlashCard {
    var text: String
    var textBackgroundColor: String
    var imageBackgroundColor: String
    var textColor: String

    init(textBackgroundColor: String, imageBackgroundColor: String, textColor: String, text: String) {
        self.textBackgroundColor = textBackgroundColor
        self.imageBackgroundColor = imageBackgroundColor
        self.textColor = textColor
        self.text = text
    }
}

@Model
class PyramidParts {
    var text: String
    var pyramidImage: String
    var voiceFile: String

    init(text: String, pyramidImage: String, voiceFile: String) {
        self.text = text
        self.pyramidImage = pyramidImage
        self.voiceFile = voiceFile
    }
}

@Model
class DragToPyramid{
    var pyramidParts : [PyramidParts]
    var textBoxes : [String]
    var isCorrectPosition : Bool = false
    
    init(pyramidParts: [PyramidParts], textBoxes: [String], isCorrectPosition: Bool) {
        self.pyramidParts = pyramidParts
        self.textBoxes = textBoxes
        self.isCorrectPosition = isCorrectPosition
    }
    
}
