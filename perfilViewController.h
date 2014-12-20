//
//  perfilViewController.h
//  Redeactiva
//
//  Created by Paola andrea Poveda vargas on 20/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface perfilViewController : UIViewController{
    NSMutableArray *filasArray;
}
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextField *pass2;
@property (strong, nonatomic) NSMutableData *responseData;
@end
