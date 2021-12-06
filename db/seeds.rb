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
                              title: 'Looking for 4995 Teammates!',
                              content: 'Hi all, I am looking for teammates for 4995 course!',
                              author_id: 1,
                              section_id: 1,
                            },
                            {
                              title: 'How to learn Ruby in 3 days',
                              content: 'Just kidding',
                              author_id: 2,
                              section_id: 1,
                            },
                            {
                              title: 'Seeking Summer 2022 Internship Opportunities',
                              content: 'Need help',
                              author_id: 1,
                              section_id: 2,
                            }
                          ])

comments = Comment.create([
                            {
                              article_id: 1,
                              author_id: 2,
                              content: "I'm also looking for teammates, how can I contact you?",
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
                              username: 'studentA',
                              email: 'studentA@columbia.edu',
                              password_digest: "123123",
                              role: 'admin',
                            },
                            {
                              username: 'studentB',
                              email: 'studentB@columbia.edu',
                              password_digest: "456456",
                              role: 'user',
                            }
                          ])

follows = Follow.create([
                      {
                        user_id: 1,
                        follower_id: 2,
                      },
                      {
                        user_id: 2,
                        follower_id: 1,
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

likes = Like.create([
                      {
                        user_id: 1,
                        article_id: 1,
                        kind: 1
                      },
                      {
                        user_id: 2,
                        article_id: 2,
                        kind: 2
                      }
                    ])