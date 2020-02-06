//
//  AppDelegate.m
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import "AppDelegate.h"
#import "AddEmailWindowController.h"
#import "EmailManager.h"

#define STATUS_ITEM_LENGTH 44.0
#define EMPTY_MENU_BAR_LENGTH 3

@interface AppDelegate ()

@property (strong, nonatomic) AddEmailWindowController *addEmailWindowController;
@property (strong, nonatomic) NSArray *emails;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_LENGTH];
    [self.statusItem setMenu:self.statusMenu];
    self.statusItem.button.image = [NSImage imageNamed:@"email"];
    self.statusItem.button.alternateImage = [NSImage imageNamed:@"email-highlighted"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
    [self updateEmailOptions];
}

- (void)optionsChanged:(NSNotification *)notification {
    [self updateEmailOptions];
}

- (void)updateEmailOptions {
    self.emails = [EmailManager getEmails];
    int currentEmailCount = (int) self.statusMenu.itemArray.count - EMPTY_MENU_BAR_LENGTH;
    if (self.emails.count > currentEmailCount) {
        int i;
        for (i = currentEmailCount; i < self.emails.count; i++) {
            //  TODO: remove string manip here once unix timestamp is old news
            NSString *email = [self.emails[i] stringByReplacingOccurrencesOfString:@"+%ld" withString:@""];
            NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:email action:@selector(copyEmail:) keyEquivalent:@""];
            [menuItem setTag:i];
            [self.statusMenu insertItem:menuItem atIndex:i];
        }
    }
}

- (IBAction)quitApp: (id)sender {
    exit(0);
}

- (IBAction)addNewEmail: (id)sender {
    if (!self.addEmailWindowController) {
        self.addEmailWindowController = [[AddEmailWindowController alloc] initWithWindowNibName:@"AddEmailWindowController"];
    }
    [self.addEmailWindowController showWindow:nil];
    [self.addEmailWindowController.window orderFrontRegardless];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)copyStringToClipboard:(NSString *)s {
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:s forType:NSPasteboardTypeString];
}

- (NSString *)getUniqueSuffix {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMddyyyy-hhmmss";
    return [formatter stringFromDate:[NSDate date]];
}

- (IBAction)copyEmail:(NSMenuItem *)sender {
    NSInteger index = sender.tag;
    NSString *email = self.emails[index];
    NSString *formatString = nil;

    //  ensure existing users can still use updated human readable timestamp
    if ([email containsString:@"+%ld"]) {
        formatString = [email stringByReplacingOccurrencesOfString:@"%ld" withString:@"%@"];
    } else {
        formatString = [email stringByReplacingOccurrencesOfString:@"@" withString:@"+%@@"];
    }

    [self copyStringToClipboard:[NSString stringWithFormat:formatString, [self getUniqueSuffix]]];
}
@end
