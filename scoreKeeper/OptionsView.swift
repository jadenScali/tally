//
//  OptionsView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-10.
//

import SwiftUI

struct OptionsView: View {
    @EnvironmentObject var env: GlobalEnviornment
    let themeColor: Color
    let needsDuration: Bool
    let namespace: Namespace.ID
    var body: some View {
        VStack {
            ScrollView {
                Text("Options")
                    .font(.largeTitle)
                        .bold()
                        .foregroundColor(themeColor)
                        .padding(.top)
                env.optionsErrorTxt
                    .font(.title3)
                    .foregroundColor(themeColor)
                Text("Players")
                    .font(.largeTitle)
                        .bold()
                    .padding()
                Menu {
                    Picker(selection: $env.playersSelected) {
                        ForEach(2...100, id: \.self) { value in
                            Text("\(value)")
                                .tag(value)
                        }
                    } label: {}
                } label: {
                    Text("\(env.playersSelected)")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.black)
                        .background()
                            .matchedGeometryEffect(id: "OptionsbgMask1", in: namespace)
                        .mask(
                            RoundedRectangle.init(cornerRadius: 30, style: .continuous)
                                .matchedGeometryEffect(id: "OptionsMask1", in: namespace)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
                }
                if needsDuration {
                    Text("Duration")
                        .font(.largeTitle)
                        .bold()
                    VStack {
                        Text("\(env.timerData[0][env.timerSelections[0]]) hrs \(env.timerData[1][env.timerSelections[1]]) min \(env.timerData[2][env.timerSelections[2]]) sec")
                            .font(.title3)
                            .foregroundColor(.black)
                            .onChange(of: env.timerData) { tag in
                                print("tyesss")
                            }
                        PickerView(data: env.timerData, selections: $env.timerSelections)
                    }
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .background()
            .matchedGeometryEffect(id: "OptionsbgMask2", in: namespace)
        .mask(
            RoundedRectangle.init(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "OptionsMask2", in: namespace)
        )
        .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
        .padding()
    }
}

struct OptionsView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        OptionsView(themeColor: Color("tropPink"), needsDuration: true, namespace: namespace).environmentObject(GlobalEnviornment())
    }
}
