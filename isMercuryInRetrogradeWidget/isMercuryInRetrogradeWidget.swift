//
//  isMercuryInRetrogradeWidget.swift
//  isMercuryInRetrogradeWidget
//
//  Created by Anna on 4/16/23.
//

import WidgetKit
import SwiftUI
import Intents
//import DataModel

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MercuryEntry {
        MercuryEntry(date:Date(), entry: "No")
    }

    func getSnapshot( in context: Context, completion: @escaping (MercuryEntry) -> ()) {
        let entry = MercuryEntry(date:Date(), entry: "No")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MercuryEntry] = []

//         Generate a timeline consisting of every day, starting from the current date.
//         TODO - do a fetch when the var changes and only then
        let currentDate = Date()
        for dayOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startDate = Calendar.current.startOfDay(for: entryDate)
            let entry = MercuryEntry(date: startDate, entry:"Yes")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MercuryEntry: TimelineEntry {
    var date: Date
    let entry: String
}

struct isMercuryInRetrogradeWidgetEntryView : View {
    var entry: Provider.Entry
    var config: StyleConfig
    
    init(entry: MercuryEntry){
        self.entry = entry
        self.config = StyleConfig.determineConfig(from: entry.entry)
    }
    var body: some View {
        ZStack{
            ContainerRelativeShape().fill(config.backgroundColor)
            VStack{
                HStack{
                    Text(entry.entry)
                        .font(.title3)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(config.primaryColor.opacity(0.5))
                }
             
                HStack{
                    Image("planet")
                        .resizable()
                        .scaledToFit()
//                        .frame(width: 10.0, height: 10.0)
               
                }
            }
           
        }
        
    }
}

struct isMercuryInRetrogradeWidget: Widget {
    let kind: String = "isMercuryInRetrogradeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            isMercuryInRetrogradeWidgetEntryView(entry: MercuryEntry(date:Date(),entry:"No"))
        }
        .configurationDisplayName("Is Mercury in Retrograde Widget")
        .description("A widget that tells you if Mercury is in retrograde at a quick glance.")
        .supportedFamilies([.systemSmall])
    }
}

struct isMercuryInRetrogradeWidget_Previews: PreviewProvider {
    static var previews: some View {
        isMercuryInRetrogradeWidgetEntryView(entry: MercuryEntry(date:Date(),entry:"No"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
