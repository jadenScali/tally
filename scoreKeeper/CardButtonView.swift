//
//  CardButtonView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

struct CardButton: View {
    @EnvironmentObject var env: GlobalEnviorment
    @State var bgImage = Image("softTouchPurple")
    @State var title = Text("title")
    @State var subtitle = Text("subtitle")
    let namespace: Namespace.ID
    var cardType: Int
    var body: some View {
        ZStack {
            VStack {
                title
                    .font(.largeTitle).bold()
                    .matchedGeometryEffect(id: "\(cardType)", in: namespace, properties: .position)
                subtitle
                    .font(.title)
                    .matchedGeometryEffect(id: "description\(cardType)", in: namespace, properties: .position)
            }
            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            .onTapGesture {
                env.currentCardButtonType = cardType
                withAnimation(.easeInOut(duration: 0.5)) { env.expandCard.toggle() }
            }
            .background(
                ZStack {
                    bgImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "Image\(cardType)", in: namespace)
                    BlurView(style: .systemUltraThinMaterialLight)
                        .opacity(0.8)
                        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                        .onTapGesture {
                            env.currentCardButtonType = cardType
                            withAnimation(.easeInOut(duration: 0.5)) { env.expandCard.toggle() }
                        }
                }
            )
            .mask(
                RoundedRectangle.init(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "Mask\(cardType)", in: namespace)
            )
            .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 10)
            .padding(32)
        }
        .onAppear {
            print(namespace)
            switch cardType {
            case 0:
                bgImage = Image("alienWater")
                title = Text("One Time Score")
                subtitle = Text("no saving")
                break
            case 1:
                bgImage = Image("colorfulMicro")
                title = Text("Long Term Score")
                subtitle = Text("saves scoreboard")
                break
            case 2:
                bgImage = Image("magicalGlass")
                title = Text("Timed Score")
                subtitle = Text("scoreboard + timer")
                break
            case 3:
                bgImage = Image("softTouchPurple")
                title = Text("Feedback")
                subtitle = Text("contact us")
                break
            default:
                print("ERROR: cardtype out of predicted range")
            }
        }
    }
}

struct CardButtonView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CardButton(namespace: namespace, cardType: 0)
    }
}
