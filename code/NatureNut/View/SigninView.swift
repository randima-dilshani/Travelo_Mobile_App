////
////  SigninView.swift
////  NatureNut
////
////  Created by Randima Dilshani on 2023-06-16.
////
//
//import SwiftUI
//
//
//
//struct SigninView: View {
//
//    @State private var email: String = ""
//
//    @State private var password: String = ""
//
//    @State private var isActive = false
//
//
//
//    var body: some View {
//
//        ZStack {
//            Text("Welcome To Travello")
//
//                .font(.largeTitle)
//                .fontWeight(.bold)
//               // .padding(.top, 10)
//
//            Image("trvelo")
//
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 200, height: 200)
//                .padding()
//
//
//            VStack(spacing: 50) {
//
//
//
//
//                VStack(spacing: 20) {
//
//                    TextField("Email", text: $email)
//
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                        .foregroundColor(.black)
//
//
//
//                    SecureField("Password", text: $password)
//
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                        .foregroundColor(.black)
//
//                }
//
//                .padding(.horizontal, 50)
//
//           Spacer()
//
//                HStack {
//
//                    Button(action: {
//
//                        withAnimation {
//
//                            isActive = true
//
//                        }
//
//                    }) {
//
//                        Text("Sign In To Travello")
//
//                            .font(.headline)
//
//                            .foregroundColor(.white)
//
//                            .padding()
//
//                            .background(Color.blue)
//
//                            .cornerRadius(10)
//
//                    }
//
//                    .padding(.horizontal, 20)
//
//                    .padding(.bottom, 40)
//
//                    .fullScreenCover(isPresented: $isActive) {
//                        ContentView()
//                    }
//                }
//                Spacer()
//                .padding(.top, 50)
//            }
//            .padding(.top, 50)
//        }
//    }
//}
//
//
//struct SigninView_Previews: PreviewProvider {
//    static var previews: some View {
//        SigninView()
//    }
//}

import SwiftUI

struct SigninView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("trvelo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()
                
                Text("Welcome To Travello")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                VStack(spacing: 50) {
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 50)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                isActive = true
                            }
                        }) {
                            Text("Sign In To Travello")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                        .fullScreenCover(isPresented: $isActive) {
                            ContentView()
                        }
                    }
                    
                    Spacer()
                        .padding(.top, 50)
                }
                .padding(.top, 50)
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
