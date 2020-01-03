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
            LoadableImageView(with: THUMBNAILER + recipe.img,
                              placeholder: MEAL_EMOJI[recipe.id % MEAL_EMOJI.count]).scaledToFit().frame(width:80, height:80).cornerRadius(8.0).padding(8.0)

            VStack(alignment: .leading) {
                Spacer()
                Text(recipe.title).font(.headline).fontWeight(.semibold).lineLimit(1)
                Text(recipe.summary.trimmingCharacters(in: .whitespacesAndNewlines)).font(.caption).fontWeight(.light).lineLimit(1).padding(.top, 3.0)
                Spacer()
            }.padding(8.0)
            Spacer()

        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe:recipeData[0])
    }
}
