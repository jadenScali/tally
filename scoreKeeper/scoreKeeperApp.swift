//
//  scoreKeeperApp.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

@main
struct scoreKeeperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GlobalEnviornment())
                .preferredColorScheme(.light)
        }
    }
}
