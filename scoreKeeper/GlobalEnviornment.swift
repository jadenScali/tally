//
//  GlobalEnviornment.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-07.
//

import Foundation
import SwiftUI

//env object
class GlobalEnviornment: ObservableObject {
    @Published var expandCard = false
    @Published var currentCardButtonType = 0
    @Published var isEditingSomwhere = false
    @Published var boxScores: [Int] = []
    @Published var boxColors: [Color] = []
    @Published var boxNames: [String] = []
}
