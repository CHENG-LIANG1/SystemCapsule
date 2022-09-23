//
//  SmallWidget.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/16.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    typealias Entry = DeviceInfoEntry
    
    
    func category(for config: SmallWidgetConfigurationIntent) -> InfoCategory {
        switch config.Info {
        case .storage:
            return .Storage
        case .battery:
            return .Battery
        case .unknown:
            return .Guide
        }
    }
    
    
    func placeholder(in context: Context) -> DeviceInfoEntry {
        DeviceInfoEntry(date: Date(), category: .Guide, configuration: SmallWidgetConfigurationIntent())
    }

    func getSnapshot(for configuration: SmallWidgetConfigurationIntent, in context: Context, completion: @escaping (DeviceInfoEntry) -> ()) {
        let entry = DeviceInfoEntry(date: Date(), category: category(for: configuration),configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: SmallWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DeviceInfoEntry] = []

        let userDefualts = UserDefaults(suiteName: "group.smallWidgetCache")
        let text = userDefualts?.string(forKey: "WIDGET_TEXT") ?? "Empty"
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = DeviceInfoEntry(date: entryDate, category: category(for: configuration), configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}



struct DeviceInfoEntry: TimelineEntry {
    let date: Date
    let category: InfoCategory
    let configuration: SmallWidgetConfigurationIntent
}

struct SmallWidgetEntryView : View {
    var entry: Provider.Entry
    var body: some View{
        VStack {
            InfoView(category: entry.category)
        }
    }
}

public enum InfoCategory: Int {
    case Storage = 1
    case Guide
    case Battery
    
    func description() -> String {
        switch self {
        case .Battery:
            return "Battery"
        case .Storage:
            return "Storage"
        case .Guide:
            return "Guide"
        }
    }
}


struct InfoView : View {
    let category: InfoCategory
    
    var body: some View {
        switch category {
        case .Battery:
            
            BatteryWidget()
            
        case .Storage:
            ZStack {
                Color.yellow
                VStack{
                    Text("Storage")
                }
            }
            
        case .Guide:
            ZStack {
                Color.white
                
                VStack (alignment: .leading, spacing: 4){
                    Text("1. Long Press")
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    Text("2. Edit Widget")
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    Text("3. Choose")
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                }
                .padding()
                
            }
        }
    }
    

    @main
    struct SmallWidget: Widget {
        let kind: String = "InfoWidget"
        
        var body: some WidgetConfiguration {
            IntentConfiguration(kind: kind, intent: SmallWidgetConfigurationIntent.self, provider: Provider()) { entry in
                SmallWidgetEntryView(entry: entry)
            }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Info Widget")
            .description("Display system info")
        }
    }
    
    //struct SmallWidget_Previews: PreviewProvider {
    //    static var previews: some View {
    //        SmallWidgetEntryView(entry: SimpleEntry(date: Date(), text:"", configuration: SmallWidgetConfigurationIntent()))
    //            .previewContext(WidgetPreviewContext(family: .systemSmall))
    //    }
    //}
}
