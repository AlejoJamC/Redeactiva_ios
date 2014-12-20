//
//  mapaViewController.h
//  Redeactiva
//
//  Created by Paola andrea Poveda vargas on 20/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface mapaViewController : UIViewController< MKMapViewDelegate >{
    BOOL _doneInitialZoom;
    IBOutlet MKMapView *Localizacion;
    NSMutableArray *filasArray;
}

@property (nonatomic, retain) IBOutlet MKMapView *Localizacion;

@end
