//
//  NSObject+EmailManager.m
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import "EmailManager.h"

#import <AppKit/AppKit.h>

@implementation EmailManager
+ (NSArray *)getEmails {
    NSArray *emails = [[NSUserDefaults standardUserDefaults] arrayForKey:EMAILS_KEY];
    if (!emails) {
        return @[];
    }
    return emails;
}

+ (void)addEmail:(NSString *)email {
    NSArray *emails = [[self getEmails] arrayByAddingObject:email];
    [[NSUserDefaults standardUserDefaults] setObject:emails forKey:EMAILS_KEY];
}
@end
