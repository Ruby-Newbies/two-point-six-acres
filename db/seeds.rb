articles = Article.create([
                            {
                              title: 'New Article',
                              content: 'This is my new article',
                              author_id: 1,
                            },
                            {
                              title: 'New Article',
                              content: 'This is my new article',
                              author_id: 2,
                            }
                          ])


comments = Comment.create([
                            {
                              article_id: 1,
                              author_id: 1,
                              content: "Great",
                            },
                            {
                              article_id: 1,
                              author_id: 2,
                              content: "wwwwwwww",
                            },
                            {
                              article_id: 2,
                              author_id: 1,
                              content: "hahahah",
                            }
                          ])