//
//  nuevaRutinaViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 20/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "nuevaRutinaViewController.h"

@interface nuevaRutinaViewController ()

@end

@implementation nuevaRutinaViewController

@synthesize responseData = _responseData;

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
    urlServicioRutinas = [NSString stringWithFormat:@"%@/rutina.php", app().urlServicio];
    // Do any additional setup after loading the view.
}
- (IBAction)crear_rutina_de_entrenamiento:(id)sender {
    NSString *dias = @"";
    if(lunes.isOn){
        dias = [NSString stringWithFormat:@"%@Lunes", dias];
    }
    
    if(martes.isOn){
        if([dias isEqualToString:@""]){
            dias = [NSString stringWithFormat:@"Martes"];
        }else{
            dias = [NSString stringWithFormat:@"%@, Martes", dias];
        }
        
    }
    
    if(miercoles.isOn){
        if([dias isEqualToString:@""]){
            dias = [NSString stringWithFormat:@"Miercoles"];
        }else{
            dias = [NSString stringWithFormat:@"%@, Miercoles", dias];
        }
        
    }
    
    if(jueves.isOn){
        if([dias isEqualToString:@""]){
            dias = [NSString stringWithFormat:@"Jueves"];
        }else{
            dias = [NSString stringWithFormat:@"%@, Jueves", dias];
        }
    }
    
    if(viernes.isOn){
        if([dias isEqualToString:@""]){
            dias = [NSString stringWithFormat:@"Viernes"];
        }else{
            dias = [NSString stringWithFormat:@"%@, Viernes", dias];
        }
    }
    
    if(sabado.isOn){
        if([dias isEqualToString:@""]){
            dias = [NSString stringWithFormat:@"Sabado"];
        }else{
            dias = [NSString stringWithFormat:@"%@, Sabado", dias];
        }
    }
    
    if(domingo.isOn){
        if([dias isEqualToString:@""]){
            dias = [NSString stringWithFormat:@"Domingo"];
        }else{
            dias = [NSString stringWithFormat:@"%@, Domingo", dias];
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *dateString = [dateFormatter stringFromDate:hora.date];
    
    NSString *titulo = titulo_de_la_rutina.text;
    self.responseData = [NSMutableData data];
    NSURL *aUrl = [NSURL URLWithString:urlServicioRutinas];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"accion=nuevaRutina&userId=%@&titulo_rutina=%@&hora=%@&dias=%@", [app() userid], titulo, dateString, dias];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                                 delegate:self];
    
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
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    
    NSError *myError = nil;
    NSDictionary *datos = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    if ([datos count] > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Su Rutina ha sido guardada con éxito"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        lunes.on = false;
        martes.on = false;
        miercoles.on = false;
        jueves.on = false;
        viernes.on = false;
        sabado.on = false;
        domingo.on = false;
        
        titulo_de_la_rutina.text =@"";
        hora.date = [NSDate date];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Lo sentimos no se ha podido guardar su rutina este momento, intentelo de nuevo más tarde..."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    }
    
    for(id key in datos) {
        NSLog(@"valor: %@",[datos objectForKey:key]);
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

@end
