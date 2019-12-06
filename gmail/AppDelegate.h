//
//  AppDelegate.h
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
- (IBAction)goloansnap:(id)sender;

@property (strong, nonatomic) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem;

@end

