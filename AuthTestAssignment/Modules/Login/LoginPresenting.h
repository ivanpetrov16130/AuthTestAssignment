#import <Foundation/Foundation.h>

@protocol LoginPresenting <NSObject>

- (void)inject:(_Nonnull id)view;

- (void)login;

- (void)transitToRegistration;

- (void)validateCredentials;

@end
