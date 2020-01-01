//
//  RecipeRow.swift
//  Recipes
//
//  Created by David Singleton on 12/30/19.
//  Copyright © 2019 David Singleton. All rights reserved.
//

import SwiftUI

struct RecipeRow: View {
    let MEAL_EMOJI = ["🍜","🍝","🍱","🌯","🥗","🥘","🌮","🍲","🌭","🍛"]
    let THUMBNAILER = "http://thumbor.us.davidsingleton.org/unsafe/400x400/"
    var recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.title).font(.headline).foregroundColor(Color.black)
            }.padding(8.0)
            Spacer()
            LoadableImageView(with: THUMBNAILER + recipe.img,
                              placeholder: MEAL_EMOJI[recipe.id % MEAL_EMOJI.count]).scaledToFit().frame(width:100, height:100).cornerRadius(8.0).padding(8.0)
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe:recipeData[0])
    }
}
