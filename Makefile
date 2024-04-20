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
