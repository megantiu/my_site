require 'kramdown'

class FileParser
  # https://github.com/haml/html2haml
  def self.html2haml
    `find . -name \*.erb -print | sed 'p;s/.erb$/.haml/' | xargs -n2 html2haml`
  end

  # Converts the passed markdown file to haml
  def self.run(name)
    input    = File.open("#{Rails.root}/md/weekly_lessons/#{name}").read
    output   = Kramdown::Document.new(input).to_html.gsub("’", "'")
    new_path = "#{Rails.root}/app/views/blog/new_post.html.erb"

    File.open(new_path, 'w') { |file| file.puts output }
    self.html2haml
    File.delete(new_path)
  end
end
