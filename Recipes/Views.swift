//
//  Views.swift
//  Products
//
//  Created by Mat Schmid on 2019-06-10.
//  Copyright © 2019 Shopify. All rights reserved.
//
// The original version of this file is MIT licensed per:
//   https://github.com/schmidyy/SwiftUI-ListFetching/blob/master/LICENSE
// Thanks Mat!

import SwiftUI

struct LoadableImageView: View {
    @ObservedObject var imageFetcher: ImageFetcher
    var placeholder: String
    
    init(with urlString: String, placeholder: String = "🍽") {
        imageFetcher = ImageFetcher(url: urlString)
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let image = UIImage(data: imageFetcher.data) {
            return AnyView(
                Image(uiImage: image).resizable()
            )
        } else {
            return AnyView(
                Text(placeholder)
                    .font(Font.system(size: 100))
                    .frame(width: 400, height: 400, alignment: Alignment.center)
            )
        }
    }
}
