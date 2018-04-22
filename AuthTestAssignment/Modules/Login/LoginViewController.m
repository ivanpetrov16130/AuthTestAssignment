#import "LoginViewController.h"


@implementation LoginViewController

- (instancetype)initWithPresenter:(_Nonnull id<LoginPresenting>)presenter {
  if (self = [super init]) {
    _presenter = presenter;
    
    _usernameTextField = [UITextField new];
    _usernameTextField.placeholder = @"Your login";
    _usernameTextField.textAlignment = NSTextAlignmentCenter;
    _usernameTextField.backgroundColor = UIColor.lightGrayColor;
    _usernameTextField.layer.cornerRadius = 4;
    _usernameTextField.clipsToBounds = YES;
    
    _passwordTextField = [UITextField new];
    _passwordTextField.placeholder = @"Your password";
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTextField.backgroundColor = UIColor.lightGrayColor;
    _passwordTextField.layer.cornerRadius = 4;
    _passwordTextField.clipsToBounds = YES;
    
    _loginButton = [UIButton new];
    [_loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    [_loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [UIButton new];
    [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
    [_registerButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_registerButton addTarget:presenter action:@selector(transitToRegistration) forControlEvents:UIControlEventTouchUpInside];

  }
  return self;
}

- (void)loadView {
  [super loadView];
  
  self.view.backgroundColor = UIColor.whiteColor;
  
  NSArray<UIView *> * subviews = @[_usernameTextField, _passwordTextField, _loginButton, _registerButton];
  [subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subview];
  }];
  
  NSLayoutAnchor * mostTopAnchor;
  if (@available(iOS 11.0, *)) {
    mostTopAnchor = self.view.safeAreaLayoutGuide.topAnchor;
  } else {
    mostTopAnchor = self.view.topAnchor;
  }
  
  [(NSArray<NSLayoutConstraint *> *)
   @[
     [_usernameTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
     [_usernameTextField.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.7],
     [_usernameTextField.topAnchor constraintEqualToAnchor:mostTopAnchor constant:self.view.bounds.size.height * 0.25],
     [_usernameTextField.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.07]
     ] enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
       [constraint setActive:YES];
     }
   ];
  
  [(NSArray<NSLayoutConstraint *> *)
   @[
     [_passwordTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
     [_passwordTextField.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.7],
     [_passwordTextField.topAnchor constraintEqualToAnchor:_usernameTextField.bottomAnchor constant:24],
     [_passwordTextField.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.07]
     ] enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
       [constraint setActive:YES];
     }
   ];
  
  NSLayoutAnchor * mostBottomAnchor;
  if (@available(iOS 11.0, *)) {
    mostBottomAnchor = self.view.safeAreaLayoutGuide.bottomAnchor;
  } else {
    mostBottomAnchor = self.view.bottomAnchor;
  }
  
  [(NSArray<NSLayoutConstraint *> *)
   @[
     [_loginButton.rightAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-16],
     [_loginButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
     [_loginButton.bottomAnchor constraintEqualToAnchor:mostBottomAnchor constant:-48],
     [_loginButton.topAnchor constraintGreaterThanOrEqualToAnchor:_passwordTextField.bottomAnchor constant:24]
     ] enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
       [constraint setActive:YES];
     }
   ];
  
  [(NSArray<NSLayoutConstraint *> *)
   @[
     [_registerButton.leftAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:16],
     [_registerButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
     [_registerButton.centerYAnchor constraintEqualToAnchor:_loginButton.centerYAnchor],
     ] enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
       [constraint setActive:YES];
     }
   ];
  
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Login";
  if (@available(iOS 11.0, *)) {
    self.navigationController.navigationBar.prefersLargeTitles = YES;
  }
}

- (void)hideValidtionErrors { 
  
}

- (void)showValidationErrors { 
  
}

- (void)show:(NSError *)error {
  
}

- (void)login {
  [_presenter loginWith:_usernameTextField.text And:_passwordTextField.text];
}


@end
