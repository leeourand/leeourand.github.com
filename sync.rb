# frozen_string_literal: true

require 'yaml'
require 'mastodon'
require 'pry'

class Post
  def self.latest = new(Dir['_posts/*'].last)
  def initialize(filename) = @filename = filename

  def toot?
    front_matter = YAML.load_file(filename)
    front_matter['category'] == 'Toots'
  end

  def content
    File
      .read(filename)
      .gsub(/\A---\n.*^---\n/m, '')
      .strip
  end

  private

  attr_reader :filename
end

if Post.latest.toot?
  token = ENV['MASTODON_TOKEN']
  puts('No MASTODON_TOKEN provided') or return unless token
  client = Mastodon::REST::Client.new(
    base_url: 'https://social.ourand.me',
    bearer_token: ENV['MASTODON_TOKEN']
  )

  client.create_status(Post.latest.content)
else
  puts "No new toots. Skipping!"
end
