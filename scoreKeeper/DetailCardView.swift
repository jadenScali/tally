//
//  DetailCardView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

struct DetailCardView: View {
    @EnvironmentObject var env: GlobalEnviorment
    @State var bgImage = Image("softTouchPurple")
    @State var title = Text("title")
    @State var description = Text("des")
    @State var buttonColor = Color("tropYellow")
    @State var showScoreBoard = false
    let namespace: Namespace.ID
    var cardType: Int
    var body: some View {
        if !showScoreBoard {
            VStack {
                bgImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "Image\(cardType)", in: namespace)
                    .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 400)
                    .mask(
                        RoundedRectangle.init(cornerRadius: 0, style: .continuous)
                            .matchedGeometryEffect(id: "Mask\(cardType)", in: namespace)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) { env.expandCard.toggle() }
                    }
                    .ignoresSafeArea()
                
                Spacer(minLength: 40)
                
                title
                    .font(.largeTitle)
                        .bold()
                        .foregroundColor(buttonColor)
                    .matchedGeometryEffect(id: "\(cardType)", in: namespace, properties: .position)
                description
                    .font(.title)
                    .minimumScaleFactor(0.1)
                    .matchedGeometryEffect(id: "description\(cardType)", in: namespace, properties: .position)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 25, maxHeight: 200)
                
                Text("Begin")
                    .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 75)
                    .background(buttonColor)
                    .clipShape(RoundedRectangle.init(cornerRadius: 30, style: .continuous))
                    .shadow(color: buttonColor.opacity(0.4), radius: 14, x: 0, y: 10)
                    .padding(40)
                    .onTapGesture {
                        showScoreBoard.toggle()
                    }
            }
            .onAppear {
                print(namespace)
                switch cardType {
                case 0:
                    bgImage = Image("alienWater")
                    title = Text("One Time Score")
                    buttonColor = Color("tropYellow")
                    description = Text("This mode is perfect for when you want to keep track of a single game. After the session this score will not save.")
                    break
                case 1:
                    bgImage = Image("colorfulMicro")
                    title = Text("Long Term Score")
                    buttonColor = Color("tropOrange")
                    description = Text("This mode should be used when you want to keep track of a long term game with a rival. Each scoreboard will never reset.")
                    break
                case 2:
                    bgImage = Image("magicalGlass")
                    title = Text("Timed Score")
                    buttonColor = Color("tropPink")
                    description = Text("This mode is for when you need a scoreboard with a timer.")
                    break
                case 3:
                    bgImage = Image("softTouchPurple")
                    title = Text("Feedback")
                    buttonColor = Color("tropPurple")
                    description = Text("Feedback is always needed. Please feel free to send any feedback positive or negative.")
                    break
                default:
                    print("ERROR: cardtype out of predicted range")
                }
            }
        } else {
            ScoreboardView()
        }
    }
}

struct DetailCardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        DetailCardView(namespace: namespace, cardType: 3)
            .previewInterfaceOrientation(.portrait)
    }
}
