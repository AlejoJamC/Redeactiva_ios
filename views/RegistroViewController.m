//
//  RegistroViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "RegistroViewController.h"

@interface RegistroViewController ()

@end

@implementation RegistroViewController
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
    viewKeyboard = false;
    return YES;
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [scrollView setContentOffset:svos animated:YES];
    [password resignFirstResponder];
    [password2 resignFirstResponder];
    [email resignFirstResponder];
    viewKeyboard = false;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    // report click to UI changer
    [scrollView setContentOffset:svos animated:YES];
    [password resignFirstResponder];
    [password2 resignFirstResponder];
    [email resignFirstResponder];
    viewKeyboard = false;
}

@synthesize responseData;
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

-(void)registrar{
    if ([email.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"El campo Email es obligatorio"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if ([password.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"El campo contraseña es obligatorio"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    if (![password.text isEqualToString:password2.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"las contraseñas no coinciden"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    self.responseData = [NSMutableData data];
    NSArray *objects = [NSArray arrayWithObjects:email.text, password.text, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"email", @"password", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login/crear",app().urlServicio]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:questionDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        NSLog(@"sdflk");
    }
 
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    //NSLog(@"Succeeded! Received: %@",self.responseData);
    
    // convert to JSON
    
    NSError *myError = nil;
    NSDictionary *datos = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    if ([[datos objectForKey:@"respuesta"] isEqualToString:@"exito"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Bienvenido, gracias por registrarte"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        app().userid = [datos objectForKey:@"id"];
        NSLog(@"userid:%@", app().userid);
        if ([app().userid intValue] > 0) {
            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"principal"] animated:YES];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Lo sentimos no se ha podido guardar su informacón en este momento, intentelo de nuevo más tarde..."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    
    
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

- (IBAction)registrarse:(id)sender {
    [self registrar];
}
@end
