#import "NotificationService.h"
#import "FirebaseMessaging.h"
#import "FirebaseAuth.h" // Add this line if you are using FirebaseAuth phone authentication
#import <UIKit/UIKit.h> // Add this line if you are using FirebaseAuth phone authentication

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

/* Uncomment this if you are using Firebase Auth
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
  if ([[FIRAuth auth] canHandleURL:url]) {
    return YES;
  }
  return NO;
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
  for (UIOpenURLContext *urlContext in URLContexts) {
    [FIRAuth.auth canHandleURL:urlContext.URL];
  }
}
*/

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];

    // Modify the notification content here...
    [[FIRMessaging extensionHelper] populateNotificationContent:self.bestAttemptContent withContentHandler:contentHandler];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end