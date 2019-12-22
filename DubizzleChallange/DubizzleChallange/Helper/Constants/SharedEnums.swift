//
//  SharedENUMS.swift
//  DubizzleChallange
//
//  Created by Alaa on 12/21/19.
//  Copyright © 2019 Dubizzle. All rights reserved.
//
import UIKit

enum LoadingType: Int {
    case Default = 1
    case Placeholder = 2
    case InfiniteScroll = 3
}
enum CollectionViewItem {
    static let width = Int(UIScreen.main.bounds.width/3) - 20
    static let height = 350
    static let spacing:CGFloat = 10.0    
}

let image_url_path = "https://image.tmdb.org/t/p/w500"
