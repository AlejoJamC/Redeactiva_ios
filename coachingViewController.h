//
//  coachingViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coachingViewController : UIViewController<UITableViewDataSource>{
    NSInteger _currentPage;
    NSInteger _totalPages;
    BOOL _cargando;
    BOOL _noMoreResultsAvail;
    
    NSMutableArray *filasArray;
    NSMutableArray *filasArray2;
    NSMutableArray *filasArray3;
    BOOL cargoCats;
    NSString *estado;
    __weak IBOutlet UILabel *fdia;
    __weak IBOutlet UILabel *fsemana;
    
}
@property (nonatomic) IBOutlet UITableView *tabla_rutinas;
@property (nonatomic) IBOutlet UITableView *tabla_cat;
@property (nonatomic) IBOutlet UIView *SideMenu;
- (IBAction)ShowHideMenu:(id)sender;

@end
