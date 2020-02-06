//
//  NSObject+EmailManager.m
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import "EmailManager.h"
#import "Underscore.h"
#define _ Underscore

#import <AppKit/AppKit.h>

@implementation EmailManager
+ (NSArray *)getEmails {
    NSArray *emails = [[NSUserDefaults standardUserDefaults] arrayForKey:EMAILS_KEY];
    if (!emails) {
        return @[];
    }
    //TODO: remove once unixtimestamp format is old news
    BOOL hasOldFormatEmails = _.any(emails, ^BOOL (NSString *email) {
        return [email containsString:@"+%ld"];
    });
    if (hasOldFormatEmails) {
        NSArray *cleanEmails = [self cleanEmails:emails];
        [self updateSavedEmails:cleanEmails];
        return cleanEmails;
    }
    return emails;
}

+ (NSArray *)cleanEmails:(NSArray *)emails {
    return _.array(emails)
    .map(^NSString *(NSString *email) {
        return [email stringByReplacingOccurrencesOfString:@"+%ld" withString:@""];
    })
    .unwrap;
}

+ (void)addEmail:(NSString *)email {
    NSArray *emails = [[self getEmails] arrayByAddingObject:email];
    [self updateSavedEmails:emails];
}

+ (void)updateSavedEmails:(NSArray *)emails {
    [[NSUserDefaults standardUserDefaults] setObject:emails forKey:EMAILS_KEY];
}
@end
