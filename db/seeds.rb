sections = Section.create([
                            {
                              title: 'Study'
                            },
                            {
                              title: 'Jobs'
                            },
                            {
                              title: 'Life'
                            }
                          ])

articles = Article.create([
                            {
                              title: 'New Article',
                              content: 'This is my new article',
                              author_id: 1,
                              section_id: 1,
                              belongs_to: 1,
                            },
                            {
                              title: 'New Article',
                              content: 'This is my new article',
                              author_id: 2,
                              section_id: 2,
                              belongs_to: 2,
                            }
                          ])


comments = Comment.create([
                            {
                              article_id: 1,
                              author_id: 1,
                              content: "Great",
                              belongs_to: 1,
                            },
                            {
                              article_id: 2,
                              author_id: 2,
                              content: "wwwwwwww",
                              belongs_to: 2,
                            },
                            {
                              article_id: 3,
                              author_id: 1,
                              content: "hahahah",
                              belongs_to: 1,
                            }
                          ])
users = User.create([
                            {
                              username: 'test1',
                              email: 'test1@columbia.edu',
                              password_digest: "123123",
                              role: 'admin',
                            },
                            {
                              username: 'test2',
                              email: 'test2@gmail.edu',
                              password_digest: "456456",
                              role: 'user',
                            }
                          ])
