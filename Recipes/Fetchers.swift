//
//  Fetchers.swift
//  Recipes
//
//  Created by David Singleton on 12/30/19.
//  Copyright © 2019 David Singleton. All rights reserved.
//

import Combine
import Foundation

class ImageFetcher: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    var data: Data = Data() {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    init(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.data = data
            }
        }.resume()
    }
}
