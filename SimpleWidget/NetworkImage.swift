//
//  NetworkImage.swift
//  WidgetSample
//  
//  Created by ji-no on 2023/07/15
//  
//

import SwiftUI

struct NetworkImage<Content: View>: View {

    private let url: URL?
    private let placeholder: Content

    init(url: URL?,
         @ViewBuilder placeholder: () -> Content)  {
        self.url = url
        self.placeholder = placeholder()
    }

    var body: some View {
        ZStack {
            if let url = url, let imageData = try? Data(contentsOf: url),
                let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(ContainerRelativeShape())
            } else {
                placeholder
            }
        }
    }
}
