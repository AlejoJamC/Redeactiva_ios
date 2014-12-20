//
//  perfilViewController.m
//  Redeactiva
//
//  Created by Paola andrea Poveda vargas on 20/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "perfilViewController.h"

@interface perfilViewController ()

@end

@implementation perfilViewController
@synthesize email, pass, pass2, responseData;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self cargarDatos];
    
}

-(void)cargarDatos{
    NSString *url =
    [NSString stringWithFormat:@"%@/login/perfil/%@",app().urlServicio, app().userid];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    if([[json objectForKey:@"respuesta"] isEqualToString:@"YES"]){
        [email setText:[json objectForKey:@"email"]];
    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actualizarPass:(id)sender {
    if ([[pass.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"El campo contraseña es obligatorio"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else{
        
        if ([[pass2.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                            message:@"Debes confirmar tu contraseña"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }else{
            
            if (![pass.text isEqualToString:pass2.text]){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                                message:@"Las contraseñas no coinciden"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }else{
                self.responseData = [NSMutableData data];
                NSArray *objects = [NSArray arrayWithObjects:email.text, pass2.text, app().userid, nil];
                NSArray *keys = [NSArray arrayWithObjects:@"email", @"password", @"id_user", nil];
                NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login/perfil/actualizar",app().urlServicio]];
                
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
            
            
        }
        
    }
    
}

- (IBAction)salir:(id)sender {
    app().userid = [NSString stringWithFormat:@"0"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:app().userid forKey:@"userIdRedeactiva"];
    [defaults synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"splash_ipad"] animated:YES];
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
    NSLog(@"Succeeded! Received: %@",[[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding]);
    
    // convert to JSON
    
    NSError *myError = nil;
    NSDictionary *datos = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    if ([[datos objectForKey:@"respuesta"] isEqualToString:@"exito"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Muy bien, cambiaste la contraseña"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        pass2.text = @"";
        pass.text = @"";
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Lo sentimos no se ha podido guardar su informacón en este momento, intentelo de nuevo más tarde..."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
