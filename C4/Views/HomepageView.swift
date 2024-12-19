//
//  HomepageView.swift
//  C4
//
//  Created by Ruba Meshal Alqahtani on 19/12/2024.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            // Path between the homes
            Image("HomePath")
                .resizable()
                .scaledToFit()
                .frame(width: 1500, height: 3300) // Adjust size to fit design
                .position(x: 700, y: 450)
            // Top Left Home (BeigeHome)
            Button(action: {
                print("Top Left Home Clicked")
            }) {
                Image("BeigeHome")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 260, height: 260) // Adjust size to fit design
            }
            .position(x: 200, y: 150) // Adjust coordinates to match layout
            
            // Bottom Right Home (BrownHome)
            Button(action: {
                print("Bottom Right Home Clicked")
            }) {
                Image("BrownHome")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 400) // Adjust size to fit design
            }
            .position(x: 900, y: 550) // Adjust coordinates to match layout
            
            // Bottom Left Character Cloud
            Image("CharacterCloud")
                .resizable()
                .scaledToFit()
                .frame(width: 517, height: 721) // Adjust size to fit design
                .position(x: 150, y: 700) // Adjust coordinates to match layout
        }
    }
}

#Preview {
    MapView()
}
