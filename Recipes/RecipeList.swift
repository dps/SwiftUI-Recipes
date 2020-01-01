/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing a list of landmarks.
 */

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject private var userData: UserData
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
                    //List {  // If you want list UI style use this instead of ScrollView
                    ForEach(response.recipes) { recipe in
                        NavigationLink(
                            destination: RecipeDetail(recipe: recipe)
                                .environmentObject(self.userData)
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
                    
                    TextField("Search", text: $userData.searchQuery).textFieldStyle(RoundedBorderTextFieldStyle()).padding(6)
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
        .environmentObject(UserData())
    }
}
