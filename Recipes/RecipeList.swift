/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            List {

                TextField("Search", text: $userData.searchQuery)
                
                ForEach(userData.recipes) { recipe in
                    NavigationLink(
                        destination: RecipeDetail(recipe: recipe)
                            .environmentObject(self.userData)
                    ) {
                        RecipeRow(recipe: recipe)
                    }
                }
            }
            .navigationBarTitle(Text("Recipes"))
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
