//
//  AppDelegate.h
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define STATUS_ITEM_LENGTH 44.0

@interface AppDelegate : NSObject <NSApplicationDelegate>
- (IBAction)goloansnap:(id)sender;

@property (strong, nonatomic) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem;

@end

