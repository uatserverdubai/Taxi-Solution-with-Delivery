# Taxi-Solution-with-Delivery
Transform your transportation business with this powerful Ride and Goods Delivery Management System

Basic :

To install, set up, and publish Taxi Delivery Solution with your branding, it's necessary to possess fundamental knowledge in both server-side 
and mobile app development since the system comprises multiple features for web and mobile applications.

- IDE for Mobile and Web development, we preferred Android Studio and VSCode.
- Flutter SDK and JDK with path setup in your IDE.
- Real server Server related knowledge like apache or local machine server, we preferred to use a real server.
- Server related knowledge and we preferred cPanel in your server for quick installation
- Basic knowledge in PHP, NPM, Vue, Node, Dart, Laravel and Flutter if you want to do some customization yourself (Not compulsory).
- basic knowledge about google cloud and firebase.


Server
Before install, please make sure you have the components bellow enable on your server

-PHP 8.1 or Greater
-OpenSSL PHP Extension
-PDO PHP Extension
-Mbstring PHP Extension
-Tokenizer PHP Extension
-XML PHP Extension
-Ctype PHP Extension
-JSON PHP Extension
-BCMath PHP Extension
-Exif PHP Extension
-Fileinfo PHP Extension
-GD PHP Extension (or Imagick PHP Extension)
-PHP Zip Archive
-PHP JSON
-PHP cURL
-PHP Zip Archive
-Rewrite Module (Apache or Nginx)
-open_basedir must be disabled

Typically, these extensions are enabled by default on most servers, but it is recommended that you confirm with your hosting provider.

Please proceed with caution and take great care in completing this task. Any errors made will not be the responsibility of our team.

Mobile App :

- Android studio
- Flutter SDK setup (latest version 3.24.0 Stable)
- JDK with path setup (only for vs code)
- Xcode for IPA file build

You can download android studio from here: developer.android.com/studio
Download Flutter SDK

Environment Setup :

Flutter SDK (https://docs.flutter.dev/get-started/install)
You can download and setup flutter from here at flutter.dev and You can follow the documentation depends on your own device and os.

Windows: https://docs.flutter.dev/get-started/install/windows

Mac: https://docs.flutter.dev/get-started/install/macos

Linux: https://docs.flutter.dev/get-started/install/linux


Now Follow the steps below to setup the script:

Unzip the downloaded package from here and open the /Source Code folder to find all the script zip. You will need to upload the FoodKing-web.zip file to your hosting web server using FTP or localhost in order to use it install it on your website and then you need to unzip this file in your server desired location.
Below is the folder structure and needs to be uploaded to your website or localhost root directory:
You should upload all files.
Now you are good to go for start the installation process from the browser
Make sure in script folder /bootstrap and /storage folder have permission as 755 recursively.
Manually create a database using “Phpmyadmin”.
Run the install script path from any web browser (http://yourdomain.com/install) and click on “Check Requirements” button.
Now you can see your php extension list if it is already installed in all extension then you can see "Check Permissions" button. Now click on this button and go to next step
Now you will see the folders permission list if everything is ok then click “Configure Environment”
Now Enter your Licence code which you created from iNiLabs and click on you will see the folders permission list if everything is ok then click “Configure Environment”
Provide your database and App information like Database Host, Database Name, Database Username, and Database Password, then click “Setup Application”
Now you will see the login information (Email : admin@example.com , Password : 123456) then click here to exit
Good Luck!!!



To use firebase follow the procedure which are mentioned below
Go to this URL to create a project https://console.firebase.google.com/u/0/. If you already have a project, continue with that.
Then go to Project Settings and create an app.
In Project Settings > General > "your created app", you will find apiKey, authDomain, projectId, storageBucket, messagingSenderId, appId, measurementId.
Click on "Cloud Messaging". There you will find a button named "Generate key pair". Click it to get the KEY PAIR.
Now in Project Settings, click "Service Account". There you will find a "Generate new private key" button. Click this button to get a JSON file.
Then go to your "shopperz" admin Dashboard > Settings > Notification. Enter your credentials and save them.
Now it's done.


To use firebase follow the procedure which are mentioned below :
Go to https://console.developers.google.com/ and generate api keys separately for ios and android. No restrictions are needed.
In main AndroidManifest.xml put the map api key
Enable android and ios api. These are free.

Payment Gateway Configuration
In our initial version we are giving two major payment gateways in the system, which are PayPal and Stripe. Admin can setup these both payment gateways from the admin panel payment settings.

SMS Gateway Configuration
We have one sms gateway integrated in the system which is Twilio and admin can setup that from admin panel -> sms settings.

How to change or customize a language?
Translate your admin and website, follow these steps:

Login into the admin panel.
Goto settings -> Languages.
Click On Add Language.
Fill all field and add new language.
Click on the view icon of the new language low in from the list.
Select file from the dropdown option under Files tab and click get file content.
All the lebels and language objectives will appear in the bottom of the field.
Now update the value of all the input fields and click save.
You do not change any word under the curly bracket text {}, example {name}.
When all language is changed then run some command in your terminal or ssh panel.
npm install
npm run prod




Change App Logo :
To change app logo replace at this file

Go to <project>assets/images/ and replace app_logo.png with your own logo.
Then run this command
flutter pub run flutter_launcher_icons
Change App Icon
To change app icon replace at this file

Go to <project>assets/images/ and replace logo.png with your own logo.
Change App Splash Icon
To change app splash icon replace at this file

Go to <project>assets/images/ and replace splash_logo.png with your own splash icon.
