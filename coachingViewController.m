//
//  coachingViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "coachingViewController.h"
#import "coachingTableViewCell.h"
#import "federacionTableViewCell.h"

@interface coachingViewController ()

@end

@implementation coachingViewController
@synthesize SideMenu;
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
    _currentPage = 1;
    _cargando = false;
    _noMoreResultsAvail = false;
    filasArray = [NSMutableArray array];
}

- (void) viewDidAppear:(BOOL)animated {
    cargoCats = true;
    self.tabla_rutinas.dataSource = self;
    self.tabla_cat.dataSource = self;
    [self cargarVideos];
    estado = @"off";
    [self cargarFrases];
    
}

-(void)cargarVideos{
    NSString *url =
    [NSString stringWithFormat:@"%@/containers/getcontainers/multimedia/%i",app().urlServicio, _currentPage];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    //self.filasArray = [json objectForKey:@"data"];
    [filasArray addObjectsFromArray:[json objectForKey:@"data"]];
    _totalPages = [[json objectForKey:@"total_pages"] intValue];
    _currentPage++;
    
    if(_currentPage > _totalPages){
        _noMoreResultsAvail = true;
    }
    
    [self.tabla_rutinas reloadData];
    
}

-(void)cargarCats{
    NSString *url =
    [NSString stringWithFormat:@"%@/coaching/videos/categorias",app().urlServicio];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    filasArray2 = [json objectForKey:@"coavideos"];
    [self.tabla_cat reloadData];
    
    cargoCats = true;
    
}

-(void)cargarFrases{
    NSString *url =
    [NSString stringWithFormat:@"%@/frases",app().urlServicio];
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    filasArray3 = [json objectForKey:@"frases"];
    
    
    [fdia setText:[[filasArray3 objectAtIndex:0] valueForKeyPath:@"frase"]];
    [fsemana setText:[[filasArray3 objectAtIndex:1] valueForKeyPath:@"frase"]];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.tabla_cat) {
        return [filasArray2 count];
    }
    
    if([ filasArray count] ==0){
        return 0;
    }
    else {
        return [filasArray count]+1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*if(tableView == self.tabla_cat){
        
        static NSString *CellIdentifier = @"cellCat";
        
        federacionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[federacionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        NSDictionary *video = [filasArray2 objectAtIndex:indexPath.row];
        
        
        [cell.titulo setText:[video valueForKeyPath:@"nombre"]];
        
        
        return cell;
    }*/
    static NSString *CellIdentifier = @"cellVideo";
    
    coachingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[coachingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (filasArray.count != 0) {
        if(indexPath.row <[filasArray count]){
            NSDictionary *video = [filasArray objectAtIndex:indexPath.row];
            
            
            [cell.titulo setText:[video valueForKeyPath:@"nombre"]];
            [cell.descripcion setText:[video valueForKeyPath:@"descripcion"]];
            [cell.contacto setText:[video valueForKeyPath:@"contacto"]];
            
            [cell.cargando stopAnimating];
            cell.cargando.hidden = YES;
        }
        else{
            if (!_noMoreResultsAvail) {
                cell.titulo.text=nil;
                cell.descripcion.text = nil;
                cell.contacto.text = nil;
                [cell.cargando startAnimating];
                cell.cargando.hidden = false;
            }
            else{
                [cell.cargando stopAnimating];
                cell.cargando.hidden=YES;
                cell.titulo.text=nil;
                cell.descripcion.text = nil;
                cell.contacto.text = nil;
                cell.descripcion.text=@"No hay más contenido para visualizar";
                
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
            [self performSelector:@selector(cargarVideos) withObject:nil afterDelay:1];
            
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tabla_cat){
        /*NSDictionary *rutaSelect = [filasArray2 objectAtIndex:indexPath.row];
        if (indexPath.row ==  0) {
            [self cargarVideos:[rutaSelect objectForKey:@"codigo"]];
        }else{
            [self cargarVideos:[rutaSelect objectForKey:@"id"]];
        }
        
        [self animar:800];
        estado = @"off";*/
    }else{
        static NSString *CellIdentifier = @"cellVideo";
        coachingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if(indexPath.row < [filasArray count]){
            if ([estado isEqualToString:@"on"]) {
                [self animar:800];
                estado = @"off";
            }
            
            NSDictionary *rutaSelect = [filasArray objectAtIndex:indexPath.row];
            [app() setRuta:rutaSelect];
            
            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"video"] animated:YES];
        }
        
        
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
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

- (IBAction)ShowHideMenu:(id)sender {
    if ([estado isEqualToString:@"off"]) {
        [self animar:469];
        estado = @"on";
        
    }else{
        [self animar:800];
        estado = @"off";
    }
    
    
}

-(void)animar:(CGFloat)x{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = SideMenu.frame;
        frame.origin.x = x;
        SideMenu.frame = frame;
    }];
}

@end
