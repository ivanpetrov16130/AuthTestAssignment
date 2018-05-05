#import <Foundation/Foundation.h>

@protocol LoginView <NSObject>

- (NSString * _Nonnull )username;

- (NSString * _Nonnull )password;

- (void)showErrorsForInvalidFields:(NSDictionary<NSString *, NSString *> * _Nullable)errorsForInvalidFields;

- (void)show:(NSError *)error;

@end
