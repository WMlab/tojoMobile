rm -rf Pods/
rm -rf TojoMobile.xcworkspace
rm -rf TojoMobile.xcodeproj/xcuserdata

if [ -d DerivedData ]
then
	rm -rf DerivedData/
fi
	
pod install