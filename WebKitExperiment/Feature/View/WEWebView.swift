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
    @State private var findNavigatorIsPresented: Bool = false
    @State private var showBookmark: Bool = false
    @State private var urlInput: String = ""
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        WebView(viewModel.page)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .webViewBackForwardNavigationGestures(.enabled)
            .webViewElementFullscreenBehavior(.enabled)
            .webViewLinkPreviews(.enabled)
            .findNavigator(isPresented: $findNavigatorIsPresented)
            .ignoresSafeArea(.all, edges: .bottom)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        guard let url = viewModel.page.url else { return }
                        viewModel.addBookmark(title: viewModel.page.title, url: url)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.primary)
                    }
                    
                    Button {
                        showBookmark.toggle()
                    } label: {
                        Image(systemName: "bookmark")
                            .foregroundStyle(.primary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Find", systemImage: "magnifyingglass") {
                        findNavigatorIsPresented.toggle()
                    }
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .disabled(viewModel.page.backForwardList.backList.isEmpty)
                    
                    Button {
                        viewModel.goForward()
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(viewModel.page.backForwardList.forwardList.isEmpty)
                    
                    TextField("Search or enter address", text: $urlInput)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            viewModel.loadPage(input: urlInput)
                        }
                }
            }
            .popover(isPresented: $showBookmark) {
                WEBookmarkView(bookmarks: $viewModel.bookmarks)
            }
            .onAppear {
                if viewModel.page.url == nil {
                    viewModel.loadPage(input: "https://www.google.com")
                }
            }
            .onChange(of: viewModel.page.url) { _, newURL in
                urlInput = newURL?.absoluteString ?? ""
            }
    }
}

#Preview {
    NavigationStack {
        WEWebView()
            .environment(WEWebViewModel())
    }
}
