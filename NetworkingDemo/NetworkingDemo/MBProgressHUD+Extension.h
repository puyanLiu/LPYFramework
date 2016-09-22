

#import <MBProgressHUD.h>


@interface MBProgressHUD (Extension)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showInfo:(NSString *)info toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showInfo:(NSString *)info;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
