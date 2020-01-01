/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing a list of landmarks.
 */

import SwiftUI

struct RecipeList: View {
    @ObservedObject var recipeListFetcher = RecipeListFetcher()

    var stateContent: AnyView {
        switch recipeListFetcher.state {
        case .loading:
            return AnyView(Text("Loading"))
        case .fetched(let result):
            switch result {
            case .failure(let error):
                return AnyView(
                    Text(error.localizedDescription)
                )
            case .success(let response):
                return AnyView(
                    //List {  // If you prefer list UI style use this instead of a ScrollView
                    ForEach(response.recipes) { recipe in
                        NavigationLink(
                            destination: RecipeDetail(path: recipe.name, partialRecipe: recipe)
                        ) {
                            RecipeRow(recipe: recipe)
                        }
                    //}
                    }
                )
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack {
                    
                    TextField("Search", text: $recipeListFetcher.searchQuery).textFieldStyle(RoundedBorderTextFieldStyle()).padding(6)
                    Spacer()
                    stateContent
                    Spacer()
                }
                .navigationBarTitle(Text("Recipes"))
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE"], id: \.self) { deviceName in
            RecipeList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
