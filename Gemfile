source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'devise'

group :test do
	gem 'rspec-rails', '~> 3.5'
	gem 'shoulda-matchers', '~> 3.0.0'
	gem 'database_cleaner'
	gem 'factory_girl_rails'
	gem 'faker'
end

group :development, :test do
	gem 'rspec-rails', '~> 3.5'
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
