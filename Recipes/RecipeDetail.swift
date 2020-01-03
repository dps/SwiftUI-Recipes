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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
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
    
    var fillColor: Color {
        return (colorScheme == ColorScheme.light) ? Color.white : Color.black
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
                }.padding().background(fillColor).cornerRadius(8).offset(y:-30).padding(.bottom, -30)
                Spacer()
                Text(message)
                    .font(.headline)
                    .foregroundColor(Color.blue)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.top)
        
    }

    
    func header(recipe: Recipe) -> some View {
        return Group {
            HStack {
                LoadableImageView(with: recipe.img).scaledToFill()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: Alignment.center)
            
            VStack {
                Text(recipe.title)
                    .font(.largeTitle)
                Text(recipe.summary)
            }.padding().background(fillColor).cornerRadius(8).offset(y:-30).padding(.bottom, -30)
        }
    }
    
    func full(recipe: Recipe) -> some View {
        return Group {
            VStack {
                VStack(alignment: .leading) {
                    TabView {
                        if recipe.ingredients != nil {
                            ScrollView {
                                header(recipe:recipe)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Ingredients")
                                            .font(.caption)
                                            .foregroundColor(Color.blue).padding()
                                        ForEach(recipe.ingredients!, id:\.self) { ingredient in
                                            HStack {
                                                Text("-")
                                                Text(ingredient.text)
                                            }.padding(8)
                                        }
                                        Spacer().frame(height:20)
                                    }
                                    Spacer()
                                }
                            }.edgesIgnoringSafeArea(.top).tabItem {
                                Image(systemName: "1.square.fill")
                                Text("Ingredients")
                            }
                        }
                        if recipe.steps != nil {
                            ScrollView {
                                header(recipe:recipe)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Steps")
                                            .font(.caption)
                                            .foregroundColor(Color.blue).padding()
                                        ForEach(recipe.steps!, id:\.self) { step in
                                            HStack {
                                                Text("👣").padding()
                                                Text(step.text)
                                            }.padding(8)
                                        }
                                        Spacer().frame(height:20)
                                    }
                                    Spacer()
                                }
                            }.edgesIgnoringSafeArea(.top).tabItem {
                                Image(systemName: "2.square.fill")
                                Text("Steps")
                            }
                        }
                        if recipe.serving != nil && recipe.serving!.count > 0{
                            ScrollView {
                                header(recipe:recipe)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Serving")
                                            .font(.caption)
                                            .foregroundColor(Color.blue).padding()
                                        ForEach(recipe.serving!, id:\.self) { serve in
                                            HStack {
                                                Text("🍽").padding()
                                                Text(serve)
                                            }.padding(8)
                                        }
                                        Spacer().frame(height:20)
                                    }
                                    Spacer()
                                }
                            }.edgesIgnoringSafeArea(.top).tabItem{
                                Image(systemName: "3.square.fill")
                                Text("Serving")
                            }
                        }
                    }.transition(AnyTransition.opacity.animation(.easeInOut))
                }.padding(0)
            }
        }.edgesIgnoringSafeArea(.top)
        
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(path: "recipe-beef-brisket-chili.md", partialRecipe: recipeDetails)
    }
}
