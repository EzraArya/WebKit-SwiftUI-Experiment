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

protocol WEWebViewModelProtocol {
    var bookmarks: [WEBookmark] { get set }
    var page: WebPage { get set }
    
    func addBookmark(title: String, url: URL)
    func clearBookmark()
    func loadPage(input: String)
}

@Observable
final class WEWebViewModel: WEWebViewModelProtocol {
    var bookmarks: [WEBookmark]
    var page: WebPage
    
    init(bookmarks: [WEBookmark] = []) {
        self.bookmarks = bookmarks
        self.page = WebPage()
    }
    
    func addBookmark(title: String, url: URL) {
        if !bookmarks.contains(where: { $0.url == url }) {
            let newBookmark = WEBookmark(url: url, title: title)
            bookmarks.append(newBookmark)
        }
    }
    
    @MainActor
    func clearBookmark() {
        bookmarks.removeAll()
    }
    
    @MainActor
    func goBack() {
        if let item = page.backForwardList.backList.last {
            page.load(item)
        }
    }
    
    @MainActor
    func goForward() {
        if let item = page.backForwardList.forwardList.first {
            page.load(item)
        }
    }
    
    @MainActor
    func loadPage(input: String) {
        var url: URL?
        
        if input.lowercased().starts(with: "http://") || input.lowercased().starts(with: "https://") {
            url = URL(string: input)
        } else if input.contains(".") && !input.contains(" ") {
            url = URL(string: "https://" + input)
        } else {
            var components = URLComponents(string: "https://www.google.com/search")!
            components.queryItems = [URLQueryItem(name: "q", value: input)]
            url = components.url
        }
        
        guard let validURL = url else {
            print("Invalid URL or search term")
            return
        }
        
        page.load(URLRequest(url: validURL))
    }
}
