//
//  ContentView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{

                            HomeView()

                                .tabItem{

                                    Image(systemName: "house")

                             Text("Home")

                                }

                          

                            AllNatureView()

                                .tabItem {

                                    Image (systemName :"photo")

               Text("All Snaps")

                                }
            MapPresentView()

                .tabItem{

                    Image(systemName: "globe")

Text("Map")

                }
            
            ProfileView()

                .tabItem{

                    Image(systemName: "person.circle")

              Text("Profile")

                }

                          
                    }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
