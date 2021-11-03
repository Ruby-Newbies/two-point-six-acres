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
                              article_id: 2,
                              author_id: 2,
                              content: "wwwwwwww",
                            },
                            {
                              article_id: 3,
                              author_id: 1,
                              content: "hahahah",
                            }
                          ])
users = User.create([
                            {
                              username: 'test1',
                              email: 'test1@columbia.edu',
                              password_digest: "123123",
                            },
                            {
                              username: 'test2',
                              email: 'test2@gmail.edu',
                              password_digest: "456456",
                            }
                          ])