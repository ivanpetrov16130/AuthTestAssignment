#import <UIKit/UIKit.h>
#import "LoginPresenting.h"
#import "LoginView.h"

@interface LoginViewController : UIViewController<LoginView>

@property(nonatomic, strong) id<LoginPresenting> presenter;

@property(nonatomic, strong) UITextField * usernameTextField;
@property(nonatomic, strong) UITextField * passwordTextField;
@property(nonatomic, strong) UIButton * loginButton;
@property(nonatomic, strong) UIButton * registerButton;

- (instancetype)initWithPresenter:(_Nonnull id<LoginPresenting>)presenter;

@end
