//
//  GameButtonView.swift
//  Satsuma
//
//  Created by Stossy11 on 13/7/2024.
//

import SwiftUI
import Foundation
import UIKit
import UniformTypeIdentifiers


struct GameButtonView: View {
    var game: SudachiGame

    var body: some View {
        VStack {
            if let image = UIImage(data: game.imageData) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 160, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
            } else {
                Image(systemName: "photo")
                    .frame(width: 48, height: 48)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(game.title)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 8)
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    Text(game.developer)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 13))
                        .padding(.horizontal, 8)
                        
                }
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 200) // Adjust minHeight as needed
    }
}
