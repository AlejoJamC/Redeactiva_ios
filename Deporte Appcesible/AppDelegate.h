//
//  AppDelegate.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UIStoryboard *storyboard;
@property (nonatomic, strong) NSString *userid;
@property (strong, nonatomic) NSDictionary *ruta;
@property (strong, nonatomic) NSDictionary *galDic;
@property (strong, nonatomic) NSString *urlServicio;
@property (strong, nonatomic) UIImage *imagenLogo;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)registrarChannel;
@end
