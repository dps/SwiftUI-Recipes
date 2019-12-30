//
//  RecipeRow.swift
//  Recipes
//
//  Created by David Singleton on 12/30/19.
//  Copyright © 2019 David Singleton. All rights reserved.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.title).font(.headline)
                //Text(recipe.summary).font(.subheadline)
            }.padding(8.0)
            Spacer()
            LoadableImageView(with: recipe.img).scaledToFill().frame(width:100, height:100).cornerRadius(8.0).padding(8.0)
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe:recipeData[0])
    }
}
