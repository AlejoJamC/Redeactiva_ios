//
//  federacionesViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 5/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "federacionesViewController.h"
#import "federacionTableViewCell.h"

@interface federacionesViewController ()

@end

@implementation federacionesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void) viewDidAppear:(BOOL)animated {
    self.tblFed.dataSource = self;
    
    [self cargarVideos];
    
}

-(void)cargarVideos{
    NSString *url =
    [NSString stringWithFormat:@"%@/federaciones",app().urlServicio];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    filasArray = [json objectForKey:@"federaciones"];
    [self.tblFed reloadData];
    
    
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
    
    return [filasArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"cellF";
    
    federacionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[federacionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *video = [filasArray objectAtIndex:indexPath.row];
    
    
    [cell.titulo setText:[video valueForKeyPath:@"nombre"]];
    [cell.direccion setText:[video valueForKeyPath:@"direccion"]];
    [cell.tele setText:[video valueForKeyPath:@"telefono"]];
    
    return cell;
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *rutaSelect = [filasArray objectAtIndex:indexPath.row];
    [app() setRuta:rutaSelect];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
