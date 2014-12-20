//
//  EntrarViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "EntrarViewController.h"

@interface EntrarViewController ()

@end

@implementation EntrarViewController

//implementation
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
    return YES;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(void) keyboardWillHide:(NSNotification *) note
{
    [scrollView setContentOffset:svos animated:YES];
    [password resignFirstResponder];
    [email resignFirstResponder];
    viewKeyboard = false;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    // report click to UI changer
    [scrollView setContentOffset:svos animated:YES];
    [password resignFirstResponder];
    [email resignFirstResponder];
    viewKeyboard = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)login{
    if ([email.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Tu email está vacio"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }
    
    if ([password.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Tu contraseña está vacia"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }
    
    NSString *url =
    [NSString stringWithFormat:@"%@/login/confirmar/%@/%@",app().urlServicio, email.text, password.text];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    NSString *res = [json objectForKey:@"respuesta"];
    if ([res isEqualToString:@"NO"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                            message:@"Datos invalidos"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alert show];
    }else{
        app().userid = [json objectForKey:@"id"];
        if (app().userid > 0) {
            [app() registrarChannel];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:app().userid forKey:@"userIdRedeactiva"];
            [defaults synchronize];
            
            [self.navigationController popToRootViewControllerAnimated:NO]; 
            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"principal"] animated:YES];
        }
    }
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

- (IBAction)entrar:(id)sender {
    [self login];
}
@end
