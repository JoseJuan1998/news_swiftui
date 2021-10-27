//
//  ArticleListView.swift
//  news
//
//  Created by jose juan alcantara rincon on 26/10/21.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    @State private var selectedArticle: Article?
    var body: some View {
        List{
            ForEach(articles){article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .onAppear {
            async {
                await articleNewsVM.loadArticles()
            }
        }
        .listStyle(PlainListStyle())
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else{
            return []
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
