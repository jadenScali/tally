//
//  ContentView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ScrollView {
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
                    
                    CardButton(
                        bgImage: Image("alienWater"),
                        title: Text("One Time Score"),
                        subtitle: Text("no saving")
                    )
                    CardButton(
                        bgImage: Image("colorfulMicro"),
                        title: Text("Long Term Score"),
                        subtitle: Text("saves scorebaord")
                    )
                    CardButton(
                        bgImage: Image("magicalGlass"),
                        title: Text("Timed Score"),
                        subtitle: Text("scoreboard + timer")
                    )
                    CardButton(
                        bgImage: Image("softTouchPurple"),
                        title: Text("Feedback"),
                        subtitle: Text("contact us")
                    )
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
