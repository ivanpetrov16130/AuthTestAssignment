#import "LoginViewController.h"


@implementation LoginViewController

- (instancetype)initWithPresenter:(_Nonnull id<LoginPresenting>)presenter {
  if (self = [super init]) {
    _presenter = presenter;
    
    _usernameTextField = [UITextField new];
    _usernameTextField.placeholder = @"Ваш логин";
    _usernameTextField.textAlignment = NSTextAlignmentCenter;
    _usernameTextField.layer.cornerRadius = 4;
    _usernameTextField.textColor = [UIColor colorWithRed:56 / 255.0 green:25 / 255.0 blue:49 / 255.0 alpha:1];
    _usernameTextField.backgroundColor = UIColor.whiteColor;
    _usernameTextField.layer.borderColor = [UIColor colorWithRed:234 / 255.0 green:46 / 255.0 blue:111 / 255.0 alpha:1].CGColor;
    _usernameTextField.layer.borderWidth = 2;
    _usernameTextField.clipsToBounds = YES;
    
    _passwordTextField = [UITextField new];
    _passwordTextField.placeholder = @"Ваш пароль";
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTextField.layer.cornerRadius = 4;
    _passwordTextField.textColor = [UIColor colorWithRed:56 / 255.0 green:25 / 255.0 blue:49 / 255.0 alpha:1];
    _passwordTextField.backgroundColor = UIColor.whiteColor;
    _passwordTextField.layer.borderColor = [UIColor colorWithRed:234 / 255.0 green:46 / 255.0 blue:111 / 255.0 alpha:1].CGColor;
    _passwordTextField.layer.borderWidth = 2;
    _passwordTextField.clipsToBounds = YES;
    
    _loginButton = [UIButton new];
    [_loginButton setTitle:@"Вход" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor colorWithRed:234 / 255.0 green:46 / 255.0 blue:111 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_loginButton addTarget:presenter action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [UIButton new];
    [_registerButton setTitle:@"Регистрация" forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:30 / 255.0 blue:63 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_registerButton addTarget:presenter action:@selector(transitToRegistration) forControlEvents:UIControlEventTouchUpInside];

  }
  return self;
}

- (void)loadView {
  [super loadView];
  
  self.view.backgroundColor = [UIColor colorWithRed:21 / 255.0 green:22 / 255.0 blue:33 / 255.0 alpha:1];
  
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
  self.navigationItem.title = @"Вход";
  if (@available(iOS 11.0, *)) {
    self.navigationController.navigationBar.prefersLargeTitles = YES;
  }
}

- (void)show:(NSError *)error {
  UIAlertController * alertViewController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
  [alertViewController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
  [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showErrorsForInvalidFields:(NSDictionary<NSString *, NSString *> * _Nullable)errorsForInvalidFields {

}

- (NSString * _Nonnull)password {
  return self.passwordTextField.text;
}


- (NSString * _Nonnull)username {
  return self.usernameTextField.text;
}



@end
