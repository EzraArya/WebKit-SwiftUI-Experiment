//
//  WebViewModel.swift
//  WebKitExperiment
//
//  Created by Ezra Arya Wijaya on 16/06/25.
//

import Foundation
import Combine
import SwiftUI
import WebKit

@Observable
final class WebViewModel {
    var bookmark: [URL]
    var page: WebPage
    
    init(bookmark: [URL] = []) {
        self.bookmark = bookmark
        self.page = WebPage()
    }
    
    func addBookmark(url: URL) {
        bookmark.append(url)
    }
    
    func clearBookmark() {
        bookmark.removeAll()
    }
    
    func loadPage(url: URL) {
        page.load(URLRequest(url: url))
    }
}
