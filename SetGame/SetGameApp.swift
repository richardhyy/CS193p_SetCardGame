//
//  SetGameApp.swift
//  SetGame
//
//  Created by Richard on 1/21/21.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetGameViewModel()
            ContentView(viewModel: game)
        }
    }
}
