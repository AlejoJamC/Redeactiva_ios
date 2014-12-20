//
//  deporteViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "deporteViewController.h"

@interface deporteViewController ()

@end

@implementation deporteViewController

@synthesize  titulo_deporte, descripcion_deporte;
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
    [cargando startAnimating];
    [self cargarDatos];
}

-(void)cargarDatos{
    NSLog(@"data: %@", app().ruta);
    
    titulo_deporte.text = [app().ruta objectForKey:@"deporte"];
    [descripcion_deporte setNumberOfLines:0];
    [descripcion_deporte sizeToFit];
    if([[app().ruta objectForKey:@"descripciondeldeporte"] isEqualToString:@""]){
        descripcion_deporte.text = @"Descripción no disponible";
    }else{
        descripcion_deporte.text= [app().ruta objectForKey:@"descripciondeldeporte"];
    }
    
    [cargando stopAnimating];
    [cargando setHidden:true];
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
