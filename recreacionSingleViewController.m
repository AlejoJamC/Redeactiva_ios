//
//  recreacionSingleViewController.m
//  Redeactiva
//
//  Created by Paola andrea Poveda vargas on 8/12/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "recreacionSingleViewController.h"

@interface recreacionSingleViewController ()

@end

@implementation recreacionSingleViewController

@synthesize  imagen_deporte, titulo_deporte, descripcion_deporte;
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
    [self cargarDatos];
}

-(void)cargarDatos{
    
    titulo_deporte.text = [app().ruta objectForKey:@"nombreprograma"];
    descripcion_deporte.text = [app().ruta objectForKey:@"descripcionprograma"];
    [descripcion_deporte setNumberOfLines:0];
    [descripcion_deporte sizeToFit];
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
