//
//  WEBookmark.swift
//  WebKitExperiment
//
//  Created by Ezra Arya Wijaya on 16/06/25.
//

import Foundation
import SwiftUI

struct WEBookmark: Identifiable, Hashable {
    let id = UUID()
    let url: URL
    let title: String
    
    init(url: URL, title: String) {
        self.url = url
        self.title = title
    }
}
