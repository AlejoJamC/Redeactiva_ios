//
//  galeriaRecViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 6/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface galeriaRecViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *filasArray;
}
@property (nonatomic) IBOutlet UITableView *tabla_rutinas;

@end
