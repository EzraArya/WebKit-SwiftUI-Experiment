//
//  WEBookmarkView.swift
//  WebKitExperiment
//
//  Created by Ezra Arya Wijaya on 16/06/25.
//

import SwiftUI

struct WEBookmarkView: View {
    @Environment(WEWebViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var bookmarks: [WEBookmark]
    
    init(bookmarks: Binding<[WEBookmark]>) {
        self._bookmarks = bookmarks
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if bookmarks.isEmpty {
                    ContentUnavailableView("No Bookmarks", systemImage: "bookmark.slash", description: Text("Add bookmarks using the '+' button."))
                } else {
                    List(bookmarks) { bookmark in
                        VStack(alignment: .leading) {
                            Text(bookmark.title)
                                .fontWeight(.semibold)
                            Text(bookmark.url.host() ?? "")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.loadPage(input: bookmark.url.absoluteString)
                            dismiss()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Bookmarks")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
