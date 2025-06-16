//
//  ContentView.swift
//  WebKitExperiment
//
//  Created by Ezra Arya Wijaya on 16/06/25.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @Environment(WebViewModel.self) private var viewModel
    @State private var showBookmark: Bool = false
    
    var body: some View {
        @Bindable var viewModel = viewModel

        VStack {
            WebView(viewModel.page)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .webViewBackForwardNavigationGestures(.enabled)
                .webViewElementFullscreenBehavior(.enabled)
                .webViewLinkPreviews(.enabled)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    guard let url = viewModel.page.url else { return }
                    viewModel.addBookmark(url: url)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(viewModel.page.title)
                    .font(.headline)
                    .foregroundStyle(.black)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showBookmark.toggle()
                } label: {
                    Image(systemName: "bookmark")
                        .foregroundStyle(.black)
                }
            }
        }
        .popover(isPresented: $showBookmark) {
            BookmarkView(bookmark: $viewModel.bookmark)
        }
        .onAppear {
            viewModel.loadPage(url: URL(string: "https://www.google.com")!)
        }
    }
}

struct BookmarkView: View {
    @Environment(WebViewModel.self) private var viewModel
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


#Preview {
    NavigationStack {
        ContentView()
            .environment(WebViewModel())
    }
}
