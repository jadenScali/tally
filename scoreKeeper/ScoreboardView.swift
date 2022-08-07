//
//  ScoreboardView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-05.
//

import SwiftUI

struct ScoreboardView: View {
    let themeColor = Color("tropYellow")
    var body: some View {
        VStack {
            ScoreBoxView(name: "Player1", themeColor: Color("tropYellow"))
            ScoreBoxView(name: "Player2", themeColor: Color("tropYellow"))
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
            .previewInterfaceOrientation(.portrait)
    }
}
