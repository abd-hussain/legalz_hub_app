clean:
	flutter clean
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf Pods
	flutter pub get
	cd ios && pod install

deploy-android:
	@echo "╠ Sending Android Build to Closed Testing..."
	cd android && bundle install
	cd android/fastlane && bundle exec fastlane deploy

deploy-ios:
	@echo "╠ Sending iOS Build to TestFlight..."
	cd ios/fastlane && bundle install
	cd ios/fastlane && bundle exec fastlane deploy

deploy: deploy-android deploy-ios

.PHONY: clean deploy-android deploy-ios
