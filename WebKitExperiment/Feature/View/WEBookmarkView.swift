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
    @Binding var bookmark: [URL]
    
    init(bookmark: Binding<[URL]>) {
        self._bookmark = bookmark
    }
    
    var body: some View {
        List(bookmark, id: \.self) { url in
            Text(String(url.absoluteString))
                .onTapGesture {
                    viewModel.loadPage(url: url)
                    dismiss()
                }
        }
        .navigationTitle("Bookmarks")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
