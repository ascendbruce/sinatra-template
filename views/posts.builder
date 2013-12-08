xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title       settings.meta_title
    xml.description settings.meta_description
    xml.link        "#{settings.site_root_url}/index"

    @posts.each do |post|
      xml.item do
        xml.title       post.title
        xml.link        "#{settings.site_root_url}/posts/#{post.id}"
        xml.description post.body
        xml.pubDate     post.created_at.rfc822
        xml.guid        "#{settings.site_root_url}/posts/#{post.id}"
      end
    end
  end
end
