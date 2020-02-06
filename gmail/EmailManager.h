//
//  NSObject+EmailManager.h
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>


#define EMAILS_KEY @"emails"

NS_ASSUME_NONNULL_BEGIN

@interface EmailManager : NSObject 
+ (NSArray *)getEmails;
+ (void)addEmail: (NSString *)email;
+ (void)clearSavedEmails;
@end

NS_ASSUME_NONNULL_END
