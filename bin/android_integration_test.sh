#!/bin/bash
set -e

pushd android

#./gradlew app:assembleAndroidTest should build our testsuite.
#But I don't think that its working as intended
#It results in a 8-10kb APK
./gradlew app:assembleAndroidTest

#Building the debug APK seems to be workign fine
./gradlew app:assembleDebug  -Ptarget="./integration_test/app_test.dart"
popd


#The following bit for uploading the app and test appears to be working just fine.
#The resulting message is "Success"

# BROWSERSTACK_USERNAME="*"
# BROWSERSTACK_ACCESS_KEY="*"


# apk_path=$(realpath ./build/app/outputs/apk/debug/app-debug.apk)
# test_path=$(realpath ./build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk)

# app_response=$(curl -u "$BROWSERSTACK_USERNAME:$BROWSERSTACK_ACCESS_KEY" \
# -X POST "https://api-cloud.browserstack.com/app-automate/flutter-integration-tests/v2/android/app" \
# -F "file=@$apk_path" \
# -F "custom_id=SampleApp")



# app_url=$(jq -r '.app_url' <<< "$app_response")
# echo $app_url

# test_response=$(curl -u "$BROWSERSTACK_USERNAME:$BROWSERSTACK_ACCESS_KEY" \
# -X POST "https://api-cloud.browserstack.com/app-automate/flutter-integration-tests/v2/android/test-suite" \
# -F "file=@$test_path")

# echo $test_response


# test_suite_url=$(jq -r '.test_suite_url' <<< "$test_response")

# run_test_response=$(curl -u "$BROWSERSTACK_USERNAME:$BROWSERSTACK_ACCESS_KEY" \
# -X POST "https://api-cloud.browserstack.com/app-automate/flutter-integration-tests/v2/android/build" \
# -d "{\"app\": \"$app_url\", \"testSuite\": \"$test_suite_url\", \"devices\": [\"Samsung Galaxy S9 Plus-9.0\"]}" \
# -H "Content-Type: application/json")

# echo $run_test_response