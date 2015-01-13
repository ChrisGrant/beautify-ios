#Getting Started

To get started, add beautify to your project's podfile by inserting the following lines. If you don't have a podfile or haven't used cocoapods before, take a look at the [getting started section of the cocoapods website](http://cocoapods.org/).

	pod 'beautify'

You can now install beautify into your project:

	$ pod install

Once this has completed, open your workspace file to get started.

	$ open YourAppName.xcworkspace

Now open up your AppDelegate implementation file and import the beautify dependency.

	#import <Beautify/Beautify.h>

Locate the your application:didFinishLaunchingWithOptions: method and add the following lines:

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
		[[BYBeautify instance] activateWithStyle:@"theme"];

This tells beautify to look for a theme.json file in your application's target, build a theme from that file, and then apply that to every control in your application. It's possible to [build a theme in code](https://github.com/beautify/beautify-ios#building-a-theme-in-code), but for now, generate one from the [beautify website](http://www.beautify.io/download.html).

On the website, you can select your style, and a colour palette, which will automatically generate a theme for you, and give you a preview on the right hand side of the page. Once you're happy with the theme you've generated, click download, and a theme.json file should be saved to your computer.

All that's left now is to add the theme.json file to your application target. Drag the file into your xcode workspace and make sure that you add the file to the target you are beautifying. Also ensure that "copy items if needed" is ticked.

That's it! You should now be able to launch your application and see the appearence you chose on the website apply to all of your controls. To learn more about how to customise individual controls and change their appearance in code, take a look at the beautify-ios project's [README](https://github.com/beautify/beautify-ios/blob/master/README.md).
