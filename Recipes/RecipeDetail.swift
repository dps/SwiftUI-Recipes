//
//  RecipeDetail.swift
//  Recipes
//
//  Created by David Singleton on 12/30/19.
//  Copyright © 2019 David Singleton. All rights reserved.
//

import SwiftUI

struct RecipeDetail: View {
    @ObservedObject var recipeDetailFetcher: RecipeDetailFetcher

    var partialRecipe: Recipe
    
    init(path: String, partialRecipe: Recipe) {
        self.partialRecipe = partialRecipe
        self.recipeDetailFetcher = RecipeDetailFetcher(path: path)
    }
    
    var body: some View {
        stateContent
    }
    
    var stateContent: AnyView {
        switch recipeDetailFetcher.state {
        case .loading:
            return AnyView(
                partial(message: "Loading...")
            )
        case .fetched(let result):
            switch result {
            case .failure(let error):
                return AnyView(
                    partial(message: error.localizedDescription)
                )
            case .success(let recipe):
                return AnyView(
                    full(recipe: recipe)
                )
            }
        }
    }
    
    func partial(message: String) -> some View {
        return ScrollView {
            VStack {
                HStack {
                    LoadableImageView(with: partialRecipe.img).scaledToFill()
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.center)
                
                VStack {
                    Text(partialRecipe.title)
                        .font(.largeTitle)
                    Text(partialRecipe.summary)
                }.padding().background(Color.white.opacity(1.0).border(Color.white.opacity(0.5), width: 2)).cornerRadius(8).offset(y:-80).padding(.bottom, -80)
                Spacer()
                Text(message)
                    .font(.headline)
                    .foregroundColor(Color.blue)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.top)
        
    }
    
    
    func full(recipe: Recipe) -> some View {
        return ScrollView {
            VStack {
                HStack {
                    LoadableImageView(with: recipe.img).scaledToFill()
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.center)
                
                VStack {
                    Text(recipe.title)
                        .font(.largeTitle)
                    Text(recipe.summary)
                }.padding().background(Color.white.opacity(1.0).border(Color.white.opacity(0.5), width: 2)).cornerRadius(8).offset(y:-80).padding(.bottom, -80)
                VStack(alignment: .leading) {
                    if recipe.ingredients != nil {
                        Text("Ingredients")
                            .font(.caption)
                            .foregroundColor(Color.blue)
                        ForEach(recipe.ingredients!, id:\.self) { ingredient in
                            HStack {
                                Text("-")
                                Text(ingredient.text)
                            }.padding(4)
                        }
                        Spacer().frame(height:20)
                    }
                    if recipe.steps != nil {
                        Text("Steps")
                            .font(.caption)
                            .foregroundColor(Color.blue)
                        ForEach(recipe.steps!, id:\.self) { step in
                            HStack(alignment: .top) {
                                Text("👣").padding(4)
                                Text(step.text).font(.headline)
                            }.fixedSize(horizontal: false, vertical: true).padding()
                        }
                        Spacer().frame(height:20)
                    }
                    if recipe.serving != nil {
                        Text("Serving").font(.caption).foregroundColor(Color.blue)
                        ForEach(recipe.serving!, id:\.self) { serving in
                            Text(serving).fixedSize(horizontal: false, vertical: true).padding()
                        }
                    }
                }.padding(8.0)
            }
        }.edgesIgnoringSafeArea(.top)
        
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(path: "recipe-beef-brisket-chili.md", partialRecipe: recipeDetails)
    }
}
