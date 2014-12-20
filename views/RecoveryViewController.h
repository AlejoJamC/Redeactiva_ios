//
//  RecoveryViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecoveryViewController : UIViewController<UITextFieldDelegate>{
    __weak IBOutlet UITextField *email;
    __weak IBOutlet UIScrollView *scrollView;
    CGPoint svos;
    BOOL viewKeyboard;
    
}

@end
