clean:
	@echo "╠ Cleaning before we start"
	flutter clean
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf Pods
	flutter pub get
	cd ios && gem install cocoapods -v 1.14.2
	cd ios && pod install

deploy-android:
	@echo "╠ Sending Android Build to Closed Testing..."
	cd android && bundle install
	cd android/fastlane && bundle exec fastlane deploy

deploy-ios:
	@echo "╠ Sending iOS Build to TestFlight..."
	@echo "╠ Step 1"
	cd ios/fastlane && bundle install
	@echo "╠ Step 2"
	cd ios/fastlane && bundle exec fastlane deploy
	@echo "╠ Finished"

deploy-web:
	@echo "╠ Sending Build to Firebase Hosting..."
	flutter build web --no-tree-shake-icons
	firebase deploy

deploy: deploy-android deploy-ios deploy-web

.PHONY: clean deploy-android deploy-ios deploy-web
