//
//  AysncImageLoader.swift
//  TestingFirebase
//
//  Created by Eric Cheung on 2022-01-30.
//

import SwiftUI

struct AysncImageLoader: View {
    
    @State var imageUrl: String
    
    var body: some View {

        AsyncImage(url: URL(string: imageUrl)) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "photo.fill")
                .resizable()
                .foregroundColor(.white)
        }

    }
}

struct AysncImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        AysncImageLoader(imageUrl: "https://i.guim.co.uk/img/media/c5e73ed8e8325d7e79babf8f1ebbd9adc0d95409/2_5_1754_1053/master/1754.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=b6ba011b74a9f7a5c8322fe75478d9df")
    }
}
