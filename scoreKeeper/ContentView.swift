//
//  ContentView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

//env object
class GlobalEnviorment: ObservableObject {
    @Published var expandCard = false
    @Published var currentCardButtonType = 0
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnviorment
    @Namespace var namespace
    var body: some View {
        if !env.expandCard {
            ScrollView {
                ZStack {
                    VStack(spacing: 5) {
                        Text("T")
                            .font(.system(size: 60)).bold()
                            .foregroundColor(Color("tropYellow"))
                        + Text("a")
                            .font(.system(size: 60)).bold()
                            .foregroundColor(Color("tropOrange"))
                        + Text("l")
                            .font(.system(size: 60)).bold()
                            .foregroundColor(Color("tropPink"))
                        + Text("l")
                            .font(.system(size: 60)).bold()
                            .foregroundColor(Color("tropPurple"))
                        + Text("y")
                            .font(.system(size: 60)).bold()
                            .foregroundColor(Color("tropBlue"))
                        
                        CardButton(namespace: namespace, cardType: 0)
                        CardButton(namespace: namespace, cardType: 1)
                        CardButton(namespace: namespace, cardType: 2)
                        CardButton(namespace: namespace, cardType: 3)
                    }
                }
            }
        } else {
            DetailCardView(namespace: namespace, cardType: env.currentCardButtonType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviorment())
            .previewDevice("iPhone 13")
    }
}
