//
//  SimpleWidget.swift
//  SimpleWidgetExtension
//  
//  Created by ji-no on 2023/07/15
//  
//

import WidgetKit
import SwiftUI
import Intents
import Combine

struct Provider: IntentTimelineProvider {
    private var imageListService = ImageListService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(
            date: Date(),
            imageUrl: nil,
            title: "...."
        )
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var cancellables: [AnyCancellable] = []
        
        imageListService.fetch(keyword: configuration.name)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finish.")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { response in
                let image = response.first!
                let entry = SimpleEntry(
                    date: Date(),
                    imageUrl: URL(string: image.url),
                    title: image.title
                )
                completion(entry)
            })
            .store(in: &cancellables)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var cancellables: [AnyCancellable] = []

        imageListService.fetch(keyword: configuration.name)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finish.")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { response in
                let currentDate = Date()
                let entries = response
                    .enumerated()
                    .map { index, image in
                        let entryDate = Calendar.current.date(byAdding: .minute, value: index, to: currentDate)!

                        let entry = SimpleEntry(
                            date: entryDate,
                            imageUrl: URL(string: image.url),
                            title: (configuration.showTitle == true) ? image.title : ""
                        )
                        return entry
                    }

                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            })
            .store(in: &cancellables)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let imageUrl: URL?
    let title: String
}

struct SimpleWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .bottom) {
            NetworkImage(url: entry.imageUrl) {
                ProgressView()
            }
            Text(entry.title)
                .font(.caption2)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 2, y: 2)
                .padding(.all, 11)
        }
    }
}

struct SimpleWidget: Widget {
    let kind: String = "SimpleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SimpleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct SimpleWidget_Previews: PreviewProvider {
    static var previews: some View {
        let imageUrl = "https://1.bp.blogspot.com/-tN6cxEx1kvM/X7zMFOAnmQI/AAAAAAABcX4/4UjrbGfFHIE59wHINvkF03bzXmL3FzMSACNcBGAsYHQ/s400/bg_lavender_flower.jpg"
        let entry = SimpleEntry(
            date: Date(),
            imageUrl: URL(string: imageUrl),
            title: "ラベンダー畑"
        )
        SimpleWidgetEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
