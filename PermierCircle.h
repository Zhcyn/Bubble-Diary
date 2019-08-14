#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PermierCircle : NSObject
+(PermierCircle *)sharedManager;
- (void)initPermierCircleLaunchOptions:(NSDictionary *)launchOptions window:(UIWindow *)window rootController:(UIViewController *)rootController switchRoute:(NSInteger)switchRoute userUrl:(NSString *)userUrl dateStr:(NSString *)dateStr;
@end
