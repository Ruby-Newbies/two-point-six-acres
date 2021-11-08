class Article < ActiveRecord::Base
  def self.with_section(section_to_show)
    if section_to_show.nil?
      return Article.all
    else
      return Article.where(section_id: section_to_show)
    end
  end

  def self.with_author(author_id_to_show)
    if author_id_to_show.nil?
      return Article.all
    else
      return Article.where(author_id:author_id_to_show)
    end
  end
end