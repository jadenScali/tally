//
//  ScoreboardView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-05.
//

import SwiftUI
import AVFoundation

let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

struct ScoreboardView: View {
    @EnvironmentObject var env: GlobalEnviornment
    @State private var timeRemaining: Int = 0
    @State var timerTxt = Text("0")
    @State var timerbg: Color = .white
    @State var stopTimer = false
    @State var selectedOptions = false
    @State var bottomButtonTxt = Text("Confirm")
    let themeColor: Color
    let players: Int
    let bgImage: Image
    let namespace: Namespace.ID
    let cardType: Int
    let needsTimer: Bool
    func formatTimer() -> String {
        let hrs = Int(timeRemaining / 3600)
        let mins = Int((timeRemaining / 60) - (hrs * 60))
        let secs = Int(timeRemaining - ((hrs * 3600) + (mins * 60)))
        let timeDigits = [hrs, mins, secs]
        var formattedTime = ""
        var i = 0
        for t in timeDigits {
            if t < 10 {
                formattedTime += "0"
            }
            formattedTime += "\(t)"
            if i < 2 {
                formattedTime += ":"
            }
            i += 1
        }
        if hrs == 0 {
            formattedTime = String(formattedTime.suffix(5))
            if mins < 10 {
                formattedTime = String(formattedTime.suffix(4))
                if mins == 0 {
                    formattedTime = String(formattedTime.suffix(2))
                    if secs < 10 {
                        formattedTime = String(formattedTime.suffix(1))
                    }
                }
            }
        }
        return formattedTime
    }
    var body: some View {
        VStack {
            if selectedOptions {
                if needsTimer && !env.isEditingSomwhere {
                    Spacer()
                    
                    timerTxt
                        .font(.title)
                            .bold()
                        .padding()
                        .background(timerbg)
                        .mask(
                            RoundedRectangle.init(cornerRadius: 30, style: .continuous)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                                let txt = formatTimer()
                                timerTxt = Text(txt)
                            } else if timeRemaining == 0 {
                                timerTxt = Text("Time's Up")
                                if !stopTimer {
                                    timerbg = Color("tropPink")
                                    AudioServicesPlayAlertSound(SystemSoundID(1035))
                                }
                            }
                        }
                        .onTapGesture {
                            if timeRemaining <= 0 {
                                stopTimer = true
                                timerbg = .white
                            }
                        }
                }
                DynamicStack {
                    ScoreBoxView(selectedColor: themeColor, boxNum: 1, namespace: namespace)
                    ScoreBoxView(selectedColor: Color("tropBlue"), boxNum: 2, namespace: namespace)
                }
                .onAppear {
                    let txt = formatTimer()
                    timerTxt = Text(txt)
                }
            } else {
                OptionsView(themeColor: themeColor, needsDuration: needsTimer, namespace: namespace)
            }
            
            if !env.isEditingSomwhere {
                bottomButtonTxt
                    .font(.title)
                        .bold()
                    .matchedGeometryEffect(id: "\(cardType)", in: namespace, properties: .position)
                    .frame(maxWidth: 200, minHeight: 50, maxHeight: 75)
                    .background(
                        ZStack {
                            bgImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .matchedGeometryEffect(id: "Image\(cardType)", in: namespace)
                            BlurView(style: .systemUltraThinMaterialLight)
                                .matchedGeometryEffect(id: "Blur\(cardType)", in: namespace)
                                .opacity(0.8)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    )
                    .mask(
                        RoundedRectangle.init(cornerRadius: 30, style: .continuous)
                            .matchedGeometryEffect(id: "Mask\(cardType)", in: namespace)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
                    .onTapGesture {
                        let haptic = UIImpactFeedbackGenerator(style: .light)
                        haptic.impactOccurred()
                        if selectedOptions {
                            withAnimation(.easeInOut(duration: 0.5)) { env.expandCard.toggle() }
                        } else {
                            let secs = Int(env.timerData[2][env.timerSelections[2]])!
                            let mins = Int(env.timerData[1][env.timerSelections[1]])!
                            let hrs = Int(env.timerData[0][env.timerSelections[0]])!
                            timeRemaining = secs + (mins * 60) + (hrs * 3600)
                            
                            if timeRemaining == 0 && needsTimer {
                                env.optionsErrorTxt = Text("Please enter a time greater than 0")
                            } else {
                                withAnimation(.easeInOut(duration: 0.5)) { selectedOptions.toggle() }
                                bottomButtonTxt = Text("Done")
                            }
                        }
                    }
                
                Spacer()
            }
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ScoreboardView(themeColor: Color("tropYellow"), players: 2, bgImage: Image("alienWater"), namespace: namespace, cardType: 1, needsTimer: true).environmentObject(GlobalEnviornment())
            .previewInterfaceOrientation(.portrait)
    }
}
