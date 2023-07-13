//
//  ProfileView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-16.
//

//import SwiftUI
//
//struct ProfileView: View {
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                Image("profile")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 150, height: 150)
//                    .clipShape(Circle())
//                    .padding(.top, 20)
//                HStack{
//                    Text("John Doe")
//                        .font(.title)
//                        .fontWeight(.bold)
//                }
//                HStack{
//                    Text("UI/UX Designer")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                Divider()
//
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                    InfoRow(iconName: "envelope", label: "johndoe@example.com")
//                    InfoRow(iconName: "phone", label: "+1 123-456-7890")
//                    InfoRow(iconName: "location", label: "New York, USA")
//                }
//                .padding(.horizontal, 20)
//
//                Spacer()
//
//                Button(action: {
//                    // Action for editing profile
//                }) {
//                    Text("Edit Profile")
//                        .foregroundColor(.white)
//                        .font(.headline)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal, 20)
//            }
//            .padding(.vertical, 20)
//        }
//    }
//}
//
//struct InfoRow: View {
//    var iconName: String
//    var label: String
//
//    var body: some View {
//        LazyHStack(spacing: 10) {
//            Image(systemName: iconName)
//                .foregroundColor(.blue)
//
//            Text(label)
//                .font(.body)
//                .foregroundColor(.black)
//
//            Spacer()
//        }
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 20)
                
                Text("John Doe")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("UI/UX Designer")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                VStack(spacing: 10) {
                    InfoRow(iconName: "envelope", label: "johndoe@example.com")
                    InfoRow(iconName: "phone", label: "+1 123-456-7890")
                }
                .padding(.horizontal, 20)
                
                InfoRow(iconName: "location", label: "New York, USA")
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: {
                    // Action for editing profile
                }) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .padding(.vertical, 20)
        }
    }
}

struct InfoRow: View {
    var iconName: String
    var label: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: iconName)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(label.components(separatedBy: "\n"), id: \.self) { line in
                    Text(line)
                        .font(.body)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
