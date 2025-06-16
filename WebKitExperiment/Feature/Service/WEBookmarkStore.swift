//
//  WEBookmarkStore.swift
//  WebKitExperiment
//
//  Created by Ezra Arya Wijaya on 16/06/25.
//

import Foundation

class WEBookmarkStore {
    private let userDefaultsKey = "saved_bookmarks"
    
    func load() -> [WEBookmark] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return []
        }
        
        do {
            let bookmarks = try JSONDecoder().decode([WEBookmark].self, from: data)
            return bookmarks
        } catch {
            print("Error decoding bookmarks: \(error)")
            return []
        }
    }
    
    func save(_ bookmarks: [WEBookmark]) {
        do {
            let data = try JSONEncoder().encode(bookmarks)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Error encoding bookmarks: \(error)")
        }
    }
}
