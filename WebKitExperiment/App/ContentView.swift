//
//  ContentView.swift
//  WebKitExperiment
//
//  Created by Ezra Arya Wijaya on 16/06/25.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            WEWebView()
                .environment(WEWebViewModel())
        }
    }
}

#Preview {
    ContentView()
}

