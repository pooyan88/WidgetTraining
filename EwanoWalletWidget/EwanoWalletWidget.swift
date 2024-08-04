//
//  EwanoWalletWidget.swift
//  EwanoWalletWidget
//
//  Created by Pooyan J on 5/12/1403 AP.
//

import WidgetKit
import SwiftUI

var mockBalances: [Balance] = [
Balance(title: "موجودی کیف پول", value: "۱۰،۰۰۰ ریال"),
Balance(title: "موجودی رفاهی", value: "۱۰،۰۰۰ ریال"),
Balance(title: "موجودی اعتباری", value: "۱۰،۰۰۰ ریال"),
Balance(title: "موجودی همراهی", value: "۱۰،۰۰۰ ریال"),
Balance(title: "موجودیشسیسشیسشی", value: "۱۰،۰۰۰ ریال"),
Balance(title: "یشسیسشیسش", value: "۱۰،۰۰۰ ریال"),
Balance(title: "یشیسشیسشیش", value: "۱۰،۰۰۰ ریال"),
Balance(title: "یشسیشسیسش", value: "۱۰،۰۰۰ ریال")
]

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), balances: [])
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), balances: [])
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, balances: [])
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let balances: [Balance]
}

struct Balance: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: String
}

struct EwanoWalletWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var body: some View {
        ZStack() {
            BackgroundView()
            VStack(alignment: .center, spacing: 8) {
                switch family {
                case .systemMedium:
                    let array = mockBalances.prefix(2)
                    ForEach(array) { item in
                        ForegroundView(title: item.title, value: item.value, widgetFamily: family, viewStyle: .verticalCenter)
                    }
                case .systemLarge:
                    let array = mockBalances.prefix(4)
                    ForEach(array) { item in
                        ForegroundView(title: item.title, value: item.value, widgetFamily: family, viewStyle: .verticalCenter)
                    }
                default:
                    ForegroundView(title: mockBalances.first?.title ?? "?", value: mockBalances.first?.value ?? "?", widgetFamily: family, viewStyle: .verticalCenter)
                }
            }
        }
    }
}

struct EwanoWalletWidget: Widget {
    @Environment(\.widgetFamily) var family
    let kind: String = "EwanoWalletWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            EwanoWalletWidgetEntryView()
                .containerBackground(.ewanoGreen, for: .widget)
        }
    }
}

#Preview(as: .systemMedium) {
    EwanoWalletWidget()
} timeline: {
    SimpleEntry(date: .now, balances: mockBalances)
}


#Preview(as: .systemSmall) {
    EwanoWalletWidget()
} timeline: {
    SimpleEntry(date: .now, balances: mockBalances)
}

#Preview(as: .systemLarge) {
    EwanoWalletWidget()
} timeline: {
    SimpleEntry(date: .now, balances: mockBalances)
}

