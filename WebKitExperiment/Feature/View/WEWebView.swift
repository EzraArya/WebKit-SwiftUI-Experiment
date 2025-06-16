//
//  WEWebView.swift
//  WebKitExperiment
//
//  Created by Ezra Arya Wijaya on 16/06/25.
//

import SwiftUI
import WebKit

struct WEWebView: View {
    @Environment(WEWebViewModel.self) private var viewModel
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
            WEBookmarkView(bookmark: $viewModel.bookmark)
        }
        .onAppear {
            viewModel.loadPage(url: URL(string: "https://www.google.com")!)
        }
    }
}

#Preview {
    NavigationStack {
        WEWebView()
            .environment(WEWebViewModel())
    }
}
