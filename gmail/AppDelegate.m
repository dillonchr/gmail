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
            NSString *email = self.emails[i];
            NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:email action:@selector(copyEmail:) keyEquivalent:@""];
            [menuItem setTag:i];
            [self.statusMenu insertItem:menuItem atIndex:i];
        }
        [self.statusMenu insertItem:[NSMenuItem separatorItem] atIndex:i];
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

- (IBAction)clearSavedEmails: (id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Clear All Saved Emails?";
    alert.informativeText = @"This will erase all emails currently stored and reset you to a clean slate.";
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    NSModalResponse answer = [alert runModal];
    if (answer == NSAlertFirstButtonReturn) {
        NSArray *emailsToRemove = [EmailManager getEmails];
        int i;
        for (i = 0; i < emailsToRemove.count; i++) {
            [self.statusMenu removeItem:[self.statusMenu itemWithTag:i]];
        }
        [EmailManager clearSavedEmails];
    }
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
    //  + and @ included because the formatted date will include those to replace @ in original email
    formatter.dateFormat = @"+MMddyyyy-hhmmss@";
    return [formatter stringFromDate:[NSDate date]];
}

- (IBAction)copyEmail:(NSMenuItem *)sender {
    NSInteger index = sender.tag;
    NSString *email = self.emails[index];
    NSString *uniqueEmail = [email stringByReplacingOccurrencesOfString:@"@" withString:[self getUniqueSuffix]];
    [self copyStringToClipboard:uniqueEmail];
}
@end
