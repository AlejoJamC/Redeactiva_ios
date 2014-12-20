//
//  EntrarViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntrarViewController : UIViewController<UITextFieldDelegate> {
    CGPoint svos;    
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UITextField *email;
    
    __weak IBOutlet UIScrollView *scrollView;
    BOOL viewKeyboard;
}
- (IBAction)entrar:(id)sender;

@end
