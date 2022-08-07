//
//  ScoreBox.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-05.
//

import SwiftUI

struct ScoreBoxView: View {
    @State var score = 0
    @State var name: String
    var themeColor: Color
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                TextField("\(name)", text: $name)
                    .font(.largeTitle)
                    .foregroundColor(themeColor)
                    .frame(maxWidth: .infinity)
                    .opacity(0.4)
                    .minimumScaleFactor(0.3)
                    .padding()
                
                Spacer()
                
                Text("\(score)")
                    .font(.system(size: 100))
                    .foregroundColor(themeColor)
                    .minimumScaleFactor(0.3)
                
                Spacer()
                
                Text("^")
                    .font(.system(size: 80))
                    .foregroundColor(themeColor)
                    .rotationEffect(Angle(degrees: 180), anchor: .center)
                    .minimumScaleFactor(0.3)
                    .onTapGesture {
                        score -= 1
                    }
            }
        }
        .mask(
            RoundedRectangle.init(cornerRadius: 30, style: .continuous)
        )
        .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
        .padding()
        .onTapGesture {
            score += 1
        }
    }
}

struct ScoreBox_Previews: PreviewProvider {
    static var previews: some View {
        ScoreBoxView(name: "Player", themeColor: Color("tropYellow"))
    }
}
