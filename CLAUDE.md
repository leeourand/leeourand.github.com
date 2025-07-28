# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal blog/website built with Jekyll and hosted on GitHub Pages at lee.ourand.me. The site features three content types: Posts (main blog content), Toots (Mastodon-style short posts), and Links (curated link posts).

## Technology Stack

- **Jekyll 3.9.5** - Static site generator via `github-pages` gem
- **Ruby/Bundler** - Package management and scripting
- **SCSS/CSS** - Styling with custom Terminal.app-inspired syntax highlighting
- **Tailwind CSS** - Utility-first CSS framework (loaded via CDN)
- **Liquid** - Templating engine for dynamic content
- **Mastodon API** - For syncing "Toot" posts

## Common Development Commands

### Local Development
```bash
# Install dependencies
bundle install

# Run Jekyll development server
bundle exec jekyll serve

# Build site for production
bundle exec jekyll build
```

### Content Management
```bash
# Create new post (manual - place in _posts/ with YAML front matter)
# File naming convention: YYYY-MM-DD-title.md

# Sync latest toot to Mastodon (requires MASTODON_TOKEN env var)
ruby sync.rb
```

## Architecture and Structure

### Content Types
- **Posts**: Main blog content in `_posts/` with category "Posts"
- **Toots**: Short-form content in `_posts/` with category "Toots" 
- **Links**: Curated links in `_posts/` with category "Links"

### Key Components
- `_layouts/base.html` - Main page template with navigation and dark mode support
- `_includes/` - Reusable components for each content type
- `_config.yml` - Jekyll configuration with Rouge syntax highlighting and pagination
- `sync.rb` - Custom Ruby script for Mastodon integration

### Content Organization
- All content uses Markdown with YAML front matter
- Permalink structure: `/:categories/:year/:month/:day/:title`
- Pagination: 10 posts per page
- Navigation configured in `_config.yml`

### Styling
- Custom SCSS in `assets/stylesheets/style.scss`
- Terminal.app-inspired syntax highlighting theme
- Tailwind CSS utilities for responsive design
- Dark mode support built into base template

### Mastodon Integration
- `sync.rb` automatically posts new "Toot" category posts to Mastodon
- Requires `MASTODON_TOKEN` environment variable
- Posts to `https://social.ourand.me` instance

## Development Notes

- No testing framework or linting tools configured
- GitHub Pages automatically builds and deploys on push to master
- Custom domain configured via CNAME file
- Images stored in `assets/images/articles/`
- Site includes PWA elements (web manifest, favicons)