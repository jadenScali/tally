//
//  BlurView.swift
//  scoreKeeper
//
//  Created by Jaden Scali on 2022-08-01.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
     
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView  {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // do nothing
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView(style: .systemUltraThinMaterialLight)
    }
}
