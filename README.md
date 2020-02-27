# t-pro-intercom-bug

## Description:

By calling `Intercom.registerUser(withUserId:, email:)`, Intercom is doing something that when the app runs for the second time, the status bar text color(the thing that shows the hour/battery/wifi icons) cannot be changed.

## Instructions:

To build the project:

 - Clone the repository
 - Run `pod install`
 - Open `T_Pro_Intercom.xcworkspace`
 - Run Project in a iPhone X or any iPhone with notch

How to reproduce the problem:

 - Open the app open for the first time (the status bar text color can change the color normally this time)
 - Close it
 - Open it again and press the blue button `Bug me`. Note that the status bar is all black, should be white.

You can also try to remove the Intercom dependency, the status bar should work normally without the dependency.

Thank you!

Pedro