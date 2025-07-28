require 'date'

desc "Create a new post"
task :new_post do
  today = Date.today
  date_str = today.strftime("%Y-%m-%d")
  
  print "Post title: "
  title = $stdin.gets.chomp
  
  if title.empty?
    puts "Error: Title cannot be empty"
    exit 1
  end
  
  # Create URL-friendly slug from title
  slug = title.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s+/, '-')
  filename = "#{date_str}-#{slug}.md"
  filepath = File.join("_posts", filename)
  
  if File.exist?(filepath)
    puts "Error: File #{filepath} already exists"
    exit 1
  end
  
  print "Post type (Posts/Toots/Links) [Posts]: "
  category = $stdin.gets.chomp
  category = "Posts" if category.empty?
  
  unless ["Posts", "Toots", "Links"].include?(category)
    puts "Error: Invalid category. Must be Posts, Toots, or Links"
    exit 1
  end
  
  # Generate appropriate frontmatter based on category
  frontmatter = case category
  when "Posts"
    <<~YAML
      ---
      category: Posts
      layout: post
      title: #{title}
      subtitle:
      ---
      
    YAML
  when "Toots"
    <<~YAML
      ---
      category: Toots
      layout: toot
      ---
      
    YAML
  when "Links"
    print "Link URL: "
    link_url = $stdin.gets.chomp
    if link_url.empty?
      puts "Error: Link URL cannot be empty for Links posts"
      exit 1
    end
    <<~YAML
      ---
      category: Links
      layout: link
      title: "#{title}"
      link: "#{link_url}"
      ---
      
    YAML
  end
  
  File.write(filepath, frontmatter)
  puts "Created new #{category.downcase.chomp('s')} post: #{filepath}"
end