//
//  mapaViewController.m
//  Redeactiva
//
//  Created by Paola andrea Poveda vargas on 20/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "mapaViewController.h"

@interface mapaViewController ()

@end

@implementation mapaViewController
@synthesize Localizacion;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self cargarEventos];
    
}

-(void)cargarEventos{
    
    CLLocationCoordinate2D LasEscaleras;
    LasEscaleras.latitude = [[app().ruta valueForKeyPath:@"latitud"] doubleValue];
    LasEscaleras.longitude = [[app().ruta valueForKeyPath:@"longitud"] doubleValue];
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = LasEscaleras;
    annotationPoint.title = [app().ruta valueForKeyPath:@"nombre"];
    annotationPoint.subtitle = [app().ruta valueForKeyPath:@"direccion"];
    [Localizacion addAnnotation:annotationPoint];
    
    /*-------------------------------------------*/
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(LasEscaleras, 680, 680);
    MKCoordinateRegion adjustedRegion = [Localizacion regionThatFits:viewRegion];
    [Localizacion setRegion:adjustedRegion animated:YES];
    
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
