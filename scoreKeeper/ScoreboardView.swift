//
//  ScoreboardView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-05.
//

import SwiftUI

struct ScoreboardView: View {
    @EnvironmentObject var env: GlobalEnviornment
    let themeColor: Color
    let players: Int
    let bgImage: Image
    let namespace: Namespace.ID
    let cardType: Int
    var body: some View {
        VStack {
            DynamicStack {
                ScoreBoxView(selectedColor: themeColor, boxNum: 1)
                ScoreBoxView(selectedColor: Color("tropBlue"), boxNum: 2)
            }
            if !env.isEditingSomwhere {
                Text("Done")
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
                        withAnimation(.easeInOut(duration: 0.5)) { env.expandCard.toggle() }
                    }
                
                Spacer()
            }
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ScoreboardView(themeColor: Color("tropYellow"), players: 2, bgImage: Image("alienWater"), namespace: namespace, cardType: 1).environmentObject(GlobalEnviornment())
            .previewInterfaceOrientation(.portrait)
    }
}
