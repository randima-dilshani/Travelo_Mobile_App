//
//  LandingView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI

struct LandingView: View {

    @State private var isActive = false

    var body: some View {

        ZStack {
      // Background Image
            Image("Land12")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .padding(.leading,-40)

            VStack{
                Spacer()
                Button(action: {
                        withAnimation {
                            isActive = true
                        }

                    }) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
}

                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    .fullScreenCover(isPresented: $isActive) {
                        // Replace `MainView()` with your main app view
                        SigninView()
                        Spacer()

                    }
            }

        }
        .statusBar(hidden: true)

    }

}
struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()

    }

}

