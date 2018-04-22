//
//  LoginPresenting.h
//  AuthTestAssignment
//
//  Created by Ivan on 22.04.2018.
//  Copyright © 2018 Ivan Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginPresenting <NSObject>

- (void)inject:(_Nonnull id)view;

- (void)loginWith:(NSString * _Nonnull )username And:(NSString * _Nonnull)password;

- (void)transitToRegistration;

- (void)validateCredentials;

@end
