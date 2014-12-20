//
//  RecoveryViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "RecoveryViewController.h"

@interface RecoveryViewController ()

@end

@implementation RecoveryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (viewKeyboard == false) {
        [scrollView setContentOffset:svos animated:NO];
        UIScrollView* v = (UIScrollView*) self.view ;
        svos = scrollView.contentOffset;
        CGPoint pt;
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:v];
        pt = rc.origin;
        pt.x = 0;
        pt.y -= 460;
        [scrollView setContentOffset:pt animated:YES];
        viewKeyboard = true;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [scrollView setContentOffset:svos animated:YES];
    [textField resignFirstResponder];
    viewKeyboard = false;
    return YES;
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [scrollView setContentOffset:svos animated:YES];
    [email resignFirstResponder];
    viewKeyboard = false;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    // report click to UI changer
    [scrollView setContentOffset:svos animated:YES];
    [email resignFirstResponder];
    viewKeyboard = false;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    singleTap.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTap];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    viewKeyboard = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)recuperar:(id)sender {
    if ([email.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Tu email está vacio"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }
    
    NSString *url =
    [NSString stringWithFormat:@"%@/login/recuperar/correo/%@",app().urlServicio, email.text];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    NSString *res = [json objectForKey:@"respuesta"];
    if ([res isEqualToString:@"YES"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Hemos enviado un mensje a tu correo con la información necesaria para recuperar tu cuenta."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Lo sentimos pero tu correo no esta registrado en nuestro portal. verifica tu información."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }

}

@end
