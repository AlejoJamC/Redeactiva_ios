//
//  historiasViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 6/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface historiasViewController : UIViewController<UITableViewDataSource>{
    NSInteger _currentPage;
    NSInteger _totalPages;
    BOOL _cargando;
    BOOL _noMoreResultsAvail;
}
@property (nonatomic) IBOutlet UITableView *tabla_rutinas;
@property (strong, nonatomic) NSMutableData *responseData;

@end
