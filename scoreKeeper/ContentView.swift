//
//  ContentView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnviornment
    @Namespace var namespace
    var body: some View {
        if !env.expandCard {
            ScrollView {
                VStack(spacing: 5) {
                    Spacer()
                    Text("T")
                        .font(.system(size: 60))
                            .bold()
                        .foregroundColor(Color("tropYellow"))
                    + Text("a")
                        .font(.system(size: 60))
                            .bold()
                        .foregroundColor(Color("tropOrange"))
                    + Text("l")
                        .font(.system(size: 60))
                            .bold()
                        .foregroundColor(Color("tropPink"))
                    + Text("l")
                        .font(.system(size: 60))
                            .bold()
                        .foregroundColor(Color("tropPurple"))
                    + Text("y")
                        .font(.system(size: 60))
                            .bold()
                        .foregroundColor(Color("tropBlue"))
                    
                    CardButton(namespace: namespace, cardType: 0)
                    CardButton(namespace: namespace, cardType: 1)
                    CardButton(namespace: namespace, cardType: 2)
                    CardButton(namespace: namespace, cardType: 3)
                }
            }
        } else {
            DetailCardView(namespace: namespace, cardType: env.currentCardButtonType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviornment())
            .previewDevice("iPhone 13")
    }
}
