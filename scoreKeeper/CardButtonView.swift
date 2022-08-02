//
//  CardButtonView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

struct CardButton: View {
    var bgImage: Image
    var title: Text
    var subtitle: Text
    var body: some View {
        ZStack {
            VStack {
                title
                    .font(.largeTitle).bold()
                subtitle
                    .font(.title)
            }
            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            .background(
                ZStack {
                    bgImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    BlurView(style: .systemUltraThinMaterialLight)
                        .opacity(0.95)
                }
            )
            .clipShape(RoundedRectangle.init(cornerRadius: 30, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding()
        }
    }
}

struct CardButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CardButton(bgImage: Image("alienWater"), title: Text("title"), subtitle: Text("subtitle"))
    }
}
