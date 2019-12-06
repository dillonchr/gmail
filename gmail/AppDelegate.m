//
//  AppDelegate.m
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_LENGTH];
    [self.statusItem setMenu:self.statusMenu];
    self.statusItem.button.image = [NSImage imageNamed:@"email"];
    self.statusItem.button.alternateImage = [NSImage imageNamed:@"email-highlighted"];
    self.statusItem.button.cell.highlighted = NO;
    //  add quit option
    [self.statusMenu addItemWithTitle:@"Quit" action:@selector(quitApp:) keyEquivalent:@"q"];
}

- (void)quitApp: (id)sender {
    exit(0);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)copyStringToClipboard:(NSString *)s {
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:s forType:NSPasteboardTypeString];
}

- (long)getUnixTimestamp {
    return (long) [[NSDate date] timeIntervalSince1970];
}


- (IBAction)goloansnap:(id)sender {
    [self copyStringToClipboard:[NSString stringWithFormat:@"dillon+%ld@goloansnap.com", [self getUnixTimestamp]]];
}
@end
