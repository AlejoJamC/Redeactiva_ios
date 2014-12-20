//
//  galeriaRecViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 6/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "galeriaRecViewController.h"
#import "galeriaTableViewCell.h"

@interface galeriaRecViewController ()

@end

@implementation galeriaRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    self.tabla_rutinas.dataSource = self;
    self.tabla_rutinas.delegate = self;
    filasArray = [NSMutableArray array];
    
    [self cargargalerias];
    
}

-(void)cargargalerias{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[app().ruta objectForKey:@"galeria1"] forKey:@"imagen"];
    [filasArray addObject:dic];
    
    [dic setObject:[app().ruta objectForKey:@"galeria2"] forKey:@"imagen"];
    [filasArray addObject:dic];
    
    [dic setObject:[app().ruta objectForKey:@"galeria3"] forKey:@"imagen"];
    [filasArray addObject:dic];
    
    [dic setObject:[app().ruta objectForKey:@"galeria4"] forKey:@"imagen"];
    [filasArray addObject:dic];
    
    [dic setObject:[app().ruta objectForKey:@"galeria5"] forKey:@"imagen"];
    [filasArray addObject:dic];
    
    [self.tabla_rutinas reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [filasArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"cellGR";
    
    galeriaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[galeriaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *galeria = [filasArray objectAtIndex:indexPath.row];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Cargamos la miniatura
        NSString *urlImagen = [galeria valueForKeyPath:@"imagen"];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlImagen]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (imageData && imageData.length > 0.5) {
                cell.imagen.image = [UIImage imageWithData: imageData];
            } else {
                // Se presentó un error
                cell.imagen.image = [UIImage imageNamed:@"white.jpg"];
            }
            
            [cell.cargando stopAnimating];
            cell.cargando.hidden = YES;
            
        });
    });
    
    return cell;
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
