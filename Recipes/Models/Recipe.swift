//
//  Recipe.swift
//  Recipes
//
//  Created by David Singleton on 12/30/19.
//  Copyright © 2019 David Singleton. All rights reserved.
//

import SwiftUI

struct Recipe: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var img: String
    var title: String
    var summary: String
    var isFavorite: Bool?

    var steps: [Step]?
    var ingredients: [Ingredient]?
    var serving: [String]?

    struct Step: Codable, Hashable {
        var img: String?
        var text: String
    }
    struct Ingredient: Codable, Hashable {
        var text: String
    }
}
