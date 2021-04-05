//
//  ShareButton.swift
//  Counter (macOS)
//
//  Created by Sebastiaan on 07/08/2020.
//

import SwiftUI

struct ShareButton: View {
    let activityItems: [Any]
    
    var body: some View {
        Button(action: {
            print("Share")
        }) {
            Image(systemName: "square.and.arrow.up")
        }
    }
}

struct ShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareButton(activityItems: ["Hello, World!"])
    }
}
