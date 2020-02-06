//
//  AddEmailWindowController.m
//  gmail
//
//  Created by Dillon Christensen on 12/6/19.
//  Copyright © 2019 Dillon Christensen. All rights reserved.
//

#import "AddEmailWindowController.h"
#import "EmailManager.h"

@interface AddEmailWindowController ()
@property (weak) IBOutlet NSTextField *emailTextField;

@end

@implementation AddEmailWindowController

- (IBAction)addNewEmail: (id) sender {
    NSString *newEmail = self.emailTextField.stringValue;
    NSArray *emailParts = [newEmail componentsSeparatedByString:@"@"];
    if (emailParts.count == 2) {
        [self.emailTextField setStringValue:@""];
        [self.window close];
        [EmailManager addEmail:newEmail];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = [NSString stringWithFormat:@"Email not found in text \"%@\"", self.emailTextField.stringValue];
        [alert runModal];
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
