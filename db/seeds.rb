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
                            },
                            {
                              title: 'New Article',
                              content: 'This is my new article',
                              author_id: 2,
                              section_id: 2,
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
                              role: 'admin',
                            },
                            {
                              username: 'test2',
                              email: 'test2@gmail.edu',
                              password_digest: "456456",
                              role: 'user',
                            }
                          ])

follows = Follow.create([
                      {
                        user_id: '1',
                        follower_id: '2',
                      },
                      {
                        user_id: '2',
                        follower_id: '1',
                      }
                    ])

usermails = Usermail.create([
                      {
                        from_user_id: 1,
                        to_user_id: 2,
                        content: "message from 1 to 2",
                        status: 1,
                      },
                      {
                        from_user_id: 2,
                        to_user_id: 1,
                        content: "message from 2 to 1",
                        status: 0,
                      }
                    ])
