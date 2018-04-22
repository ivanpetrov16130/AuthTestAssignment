//
//  LoginView.h
//  AuthTestAssignment
//
//  Created by Ivan on 22.04.2018.
//  Copyright © 2018 Ivan Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginView <NSObject>

- (void)showValidationErrors;

- (void)hideValidtionErrors;

- (void)show:(NSError *)error;

@end
