install:
	bundle install

open:
	open statium-ios-swift.xcodeproj

build:
	bundle exec fastlane ios build

docs:
	bundle exec jazzy

lint:
	bundle exec rubocop
	bundle exec fastlane ios lint

test:
	bundle exec fastlane ios tests

screenshots:
	bundle exec fastlane ios screenshots

.PHONY: build, docs
