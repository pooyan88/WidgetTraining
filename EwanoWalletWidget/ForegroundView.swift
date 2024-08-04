//
//  ForegroundView.swift
//  EwanoWidget
//
//  Created by Pooyan J on 5/13/1403 AP.
//

import SwiftUI
import WidgetKit

enum ViewStyle {
    case verticalCenter, horizontal, verticalTwoSides
}

struct ForegroundView: View {
    @State var title: String
    @State var value: String
    var widgetFamily: WidgetFamily
    @State var viewStyle: ViewStyle
    var body: some View {
        if widgetFamily == .systemMedium || widgetFamily == .systemLarge {
            switch viewStyle {
            case .verticalCenter:
                VStack {
                    TitleSection(title: title, widgetFamily: widgetFamily)
                    Text(value)
                        .font(.title3)
                        .foregroundColor(.white)
                }
            case .horizontal:
                HStack {
                    Text(value)
                        .font(.title3)
                        .foregroundColor(.white)
                    Spacer()
                    TitleSection(title: title, widgetFamily: widgetFamily)
                }
            case .verticalTwoSides:
                HStack {
                    Text(value)
                        .font(.title3)
                        .foregroundColor(.white)
                        .offset(y: 10)
                    Spacer()
                    TitleSection(title: title, widgetFamily: widgetFamily)
                        .offset(y: -20)
                }
            }
        } else {
            VStack {
                TitleSection(title: title, widgetFamily: widgetFamily, alignment: .vertical)
                Text(value)
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
    }
}

struct TitleSection: View {
    enum Alignment { case vertical, horizontal }
    var title: String
    var widgetFamily: WidgetFamily
    @State var alignment: Alignment = .horizontal
    private var font: Font {
        switch widgetFamily {
        case .systemSmall: return .callout
        case .systemMedium, .systemLarge: return .title3
        default: return .title3
        }
    }
    var body: some View {
        switch alignment {
        case .vertical:
            VStack(alignment: .center) {
                Image("wallet").renderingMode(.template)
                Text(title).font(font)
            }
            .foregroundColor(.white)
        case .horizontal:
            HStack(alignment: .center) {
                Text(title).font(font)
                Image("wallet").renderingMode(.template)
            }
            .foregroundColor(.white)
        }
    }
}
