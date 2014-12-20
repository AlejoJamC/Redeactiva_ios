//
//  RegistroViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegistroViewController : UIViewController<UITextFieldDelegate>{
    
    __weak IBOutlet UITextField *password2;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UITextField *email;
    __weak IBOutlet UIScrollView *scrollView;
    CGPoint svos;
    BOOL viewKeyboard;
}

- (IBAction)registrarse:(id)sender;

@property (strong, nonatomic) NSMutableData *responseData;

@end
