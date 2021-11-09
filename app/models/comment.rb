class Comment < ActiveRecord::Base
  belongs_to :article
  def self.with_article_id(comments_of_the_article_to_show)
    if comments_of_the_article_to_show.nil?
      return Comment.all
    else
      return Comment.where(article_id: comments_of_the_article_to_show)
    end
  end
end