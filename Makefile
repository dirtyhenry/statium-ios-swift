install:
	bundle install

open:
	open statium-ios-swift.xcodeproj

build:
	bundle exec fastlane ios build

test:
	bundle exec fastlane ios tests

screenshots:
	bundle exec fastlane ios screenshots

.PHONY: build
