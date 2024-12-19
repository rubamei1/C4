//
//  C4App.swift
//  C4
//
//  Created by Ruba Meshal Alqahtani on 17/12/2024.
//
import SwiftUI
import SwiftData

@main
struct C4App: App {
    var body: some Scene {
        WindowGroup {
            FlashcardView()
                .modelContainer(for: [Word.self, FlashCard.self])
        }
    }
}
