//
//  historiasViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 6/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "historiasViewController.h"
#import "recreacionTableViewCell.h"

@interface historiasViewController ()
@property (nonatomic, retain) NSMutableArray *filasArray;
@end

@implementation historiasViewController
@synthesize filasArray = _filasArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.filasArray = [NSMutableArray array];
    _currentPage = 1;
    _cargando = false;
    _noMoreResultsAvail = false;
    
}

- (void) viewDidAppear:(BOOL)animated {
    self.tabla_rutinas.dataSource = self;
    
    [self cargarHistorias];
    
}

-(void)cargarHistorias{
    _cargando = true;
    NSString *url =
    [NSString stringWithFormat:@"%@/historias/%i",app().urlServicio, _currentPage];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    //self.filasArray = [json objectForKey:@"data"];
    [self.filasArray addObjectsFromArray:[json objectForKey:@"data"]];
    _totalPages = [[json objectForKey:@"total_paginas"] intValue];
    _currentPage++;
    
    if(_currentPage > _totalPages){
        _noMoreResultsAvail = true;
    }
    
    [self.tabla_rutinas reloadData];
    
    
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if([ self.filasArray count] ==0){
        return 0;
    }
    else {
        return [self.filasArray count]+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    
    static NSString *CellIdentifier = @"cellH";
    
    recreacionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[recreacionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (self.filasArray.count != 0) {
        if(indexPath.row <[self.filasArray count]){
            NSDictionary *historia = [self.filasArray objectAtIndex:indexPath.row];
            
            [cell.titulo setText:[historia valueForKeyPath:@"descripcion"]];
            
            NSString *url = [historia valueForKeyPath:@"adjunto"];
            
            if (![cell.imageView.image isEqual:nil]) {
                if (![url isKindOfClass:[NSNull class]]) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        // Cargamos la miniatura
                        NSString *urlImagen = url;
                        
                        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlImagen]];
                        
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [cell.img setImage:[UIImage imageWithData: imageData]];
                            [cell.cargando stopAnimating];
                            cell.cargando.hidden = true;
                            
                            
                        });
                    });
                }
            }
                        
        }
        else{
            
            if (!_noMoreResultsAvail) {
                cell.titulo.text=nil;
                [cell.cargando startAnimating];
                cell.cargando.hidden = false;
            }
            else{
                [cell.cargando stopAnimating];
                cell.cargando.hidden=YES;
                
                cell.titulo.text=@"No hay más Historias para visualizar";
            }
            
            _cargando = false;
            
        }
    }

    
    return cell;
    
    
}

#pragma UIScroll View Method::
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!_cargando && !_noMoreResultsAvail) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self performSelector:@selector(cargarHistorias) withObject:nil afterDelay:1];
            
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
