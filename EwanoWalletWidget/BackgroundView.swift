//
//  BackgroundView.swift
//  EwanoWalletWidgetExtension
//
//  Created by Pooyan J on 5/13/1403 AP.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack() {
            Color.ewanoGreen
                .ignoresSafeArea()
            Image("butterfly")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .clipped()
                .opacity(0.1)
        }
    }
}
