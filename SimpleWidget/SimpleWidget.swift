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

struct Provider: IntentTimelineProvider {
    let images: [(title: String, url: String)] = [
        (title: "ラベンダー畑", url: "https://1.bp.blogspot.com/-tN6cxEx1kvM/X7zMFOAnmQI/AAAAAAABcX4/4UjrbGfFHIE59wHINvkF03bzXmL3FzMSACNcBGAsYHQ/s400/bg_lavender_flower.jpg"),
        (title: "空に打ち上がる花火", url: "https://2.bp.blogspot.com/--XyGmSuFJtk/XOPXPWcaKTI/AAAAAAABS6s/9zxLQUKTqzUs9NW4mJWhUvdaG8P_Ab66ACLcBGAs/s400/hanabi_sky.png"),
        (title: "緑のチェック柄", url: "https://4.bp.blogspot.com/-P6hcAiGH5tM/XJB4o9PCeXI/AAAAAAABR4o/1jsOQ6q51io1x7g0VrloLp_Ck0p_4OLlACLcBGAs/s400/christmas_check_pattern_green.png"),
        (title: "赤のチェック柄", url: "https://3.bp.blogspot.com/-AxyELGPAOVk/XJB4pHZiczI/AAAAAAABR4s/e8-XbZ_4lB4F4M1z-zDNRIKVMwJbm4FswCLcBGAs/s400/christmas_check_pattern_red.png"),
        (title: "おもちゃ屋", url: "https://3.bp.blogspot.com/-Dh-Mg5g3gVA/WtRyxal4kZI/AAAAAAABLhc/q9dIX7_Fj3gK4MokFS0juvVxSx1xSJxMgCLcBGAs/s400/building_omocha.png"),
        (title: "ダイアモンドダスト", url: "https://4.bp.blogspot.com/-2VRNdggYAgQ/W1a4g3dvDTI/AAAAAAABNgE/nNiEgghSMTwYS0QgcNdQg6uCu_Ph38BjACLcBGAs/s180-c/bg_snow_diamond_dust.jpg"),
        (title: "桜並木", url: "https://2.bp.blogspot.com/-ngdlNja37lk/XJhwPsT0QtI/AAAAAAABSEc/WnLJE71Okgsn_IHlNfzohvE0CXfLOTEkACLcBGAs/s180-c/bg_namikimichi1_sakura.jpg"),
        (title: "川の中", url: "https://1.bp.blogspot.com/-0XUYPcO40n8/X5OcHdsaQTI/AAAAAAABb5M/9FW4NZlp5oklDgUSqAa9i3cekGp8PjGQACNcBGAsYHQ/s180-c/bg_natural_river.jpg"),
        (title: "紅葉した山と田んぼ", url: "https://4.bp.blogspot.com/-Eh202n-SoSs/We6SagKmT-I/AAAAAAABHxk/AzQtRIej8IIdZ4VbbL7buQolpzQO-UACgCLcBGAs/s180-c/bg_tanbo_aki.jpg"),
        (title: "ホログラムシール", url: "https://4.bp.blogspot.com/-aOCh3m2lvJs/WEVof8kUhjI/AAAAAAABANo/nd7um4KXL3QMh7AahC2gAsGFq7sI2qvrgCLcB/s180-c/hologram_kira_sticker_color.png"),

        
    ]
    
    func placeholder(in context: Context) -> SimpleEntry {
        let image = images.first!
        return SimpleEntry(
            date: Date(),
            imageUrl: URL(string: image.url),
            title: image.title
        )
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let image = images.first!
        let entry = SimpleEntry(
            date: Date(),
            imageUrl: URL(string: image.url),
            title: image.title
        )
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        
        let currentDate = Date()
        for index in 0 ..< images.count {
            let entryDate = Calendar.current.date(byAdding: .minute, value: index, to: currentDate)!

            let image = images[index]
            let entry = SimpleEntry(
                date: entryDate,
                imageUrl: URL(string: image.url),
                title: image.title
            )
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
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
