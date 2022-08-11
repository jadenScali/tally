//
//  ScoreBox.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-05.
//

import SwiftUI

struct ScoreBoxView: View {
    @EnvironmentObject var env: GlobalEnviornment
    @State var score = 0
    @State var name: String = ""
    @State var selectedColor: Color
    let boxNum: Int
    let namespace: Namespace.ID
    private let colors: [Color] = [
        Color("tropYellow"),
        Color("tropOrange"),
        Color("tropPink"),
        Color("tropPurple"),
        Color("tropBlue")
    ]
    var body: some View {
        ZStack {
            VStack {
                TextField(
                    "\(name)",
                    text: $name,
                    onEditingChanged: { isBegin in
                        if isBegin {
                            env.isEditingSomwhere = true
                        } else {
                            env.boxNames[boxNum - 1] = name
                            env.isEditingSomwhere = false
                        }
                    }
                )
                    .font(.largeTitle)
                    .foregroundColor(selectedColor)
                    .frame(maxWidth: .infinity)
                    .opacity(0.4)
                    .padding()
                                    
                Spacer()
                
                if !env.isEditingSomwhere {
                    Text("\(score)")
                        .font(.system(size: 100))
                        .foregroundColor(selectedColor)
                        .minimumScaleFactor(0.1)
                        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .background(.white)
                        .onTapGesture {
                            let haptic = UIImpactFeedbackGenerator(style: .soft)
                            haptic.impactOccurred()
                            score += 1
                            env.boxScores[boxNum - 1] = score
                        }
                    Spacer()
                    
                    Text("^")
                        .font(.system(size: 80))
                        .rotationEffect(Angle(degrees: 180), anchor: .center)
                        .foregroundColor(selectedColor)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .minimumScaleFactor(0.1)
                        .onTapGesture {
                            score -= 1
                            env.boxScores[boxNum - 1] -= 1
                            let haptic = UIImpactFeedbackGenerator(style: .soft)
                            haptic.impactOccurred()
                        }
                } else {
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .foregroundColor(color)
                                .frame(width: 45, height: 45)
                                .opacity(color == selectedColor ? 1.0 : 0.3)
                                .onTapGesture {
                                    let haptic = UIImpactFeedbackGenerator(style: .light)
                                    haptic.impactOccurred()
                                    selectedColor = color
                                    env.boxColors[boxNum - 1] = selectedColor
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .background()
            .matchedGeometryEffect(id: "OptionsbgMask\(boxNum)", in: namespace)
        .mask(
            RoundedRectangle.init(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "OptionsMask\(boxNum)", in: namespace)
        )
        .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
        .padding()
        .onAppear {
            while env.boxScores.count < boxNum {
                env.boxScores += [0]
                env.boxNames += [""]
                env.boxColors += [.black]
            }
            
            if env.boxColors[boxNum - 1] == .black {
                name = "Player\(boxNum)"
                env.boxScores[boxNum - 1] = score
                env.boxNames[boxNum - 1] = name
                env.boxColors[boxNum - 1] = selectedColor
            } else {
                score = env.boxScores[boxNum - 1]
                name = env.boxNames[boxNum - 1]
                selectedColor = env.boxColors[boxNum - 1]
            }
        }
    }
}

struct ScoreBox_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ScoreBoxView(name: "Player", selectedColor: Color("tropYellow"), boxNum: 1, namespace: namespace).environmentObject(GlobalEnviornment())
    }
}
