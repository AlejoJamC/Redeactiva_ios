//
//  todosEventosViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "todosEventosViewController.h"
#import "eventoTableViewCell.h"

@interface todosEventosViewController ()

@end

@implementation todosEventosViewController

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
}

- (void) viewDidAppear:(BOOL)animated {
    self.tabla_rutinas.dataSource = self;
    
    [self cargarEventos];
    
}

-(void)cargarEventos{
    NSString *url =
    [NSString stringWithFormat:@"%@/eventos",app().urlServicio];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    filasArray = [json objectForKey:@"eventos"];
    [self.tabla_rutinas reloadData];
    
    
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
    
    
    static NSString *CellIdentifier = @"cellEvt";
    
    eventoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[eventoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *deporte = [filasArray objectAtIndex:indexPath.row];
    
    
    [cell.titulo_evento setText:[NSString stringWithFormat:@"%@ %@",cell.titulo_evento.text, [deporte valueForKeyPath:@"nombre"]]];
    [cell.telefonos setText:[NSString stringWithFormat:@"%@ %@",cell.telefonos.text, [deporte valueForKeyPath:@"telefono"]]];
    [cell.horario setText:[NSString stringWithFormat:@"%@ Inicia: %@ a las %@ - Termina: %@ a las %@",cell.horario.text, [deporte valueForKeyPath:@"fechainicial"], [deporte valueForKeyPath:@"horainicial"], [deporte valueForKeyPath:@"fechafinal"], [deporte valueForKeyPath:@"horafinal"]]];
    [cell.costo_evento setText:[NSString stringWithFormat:@"%@ %@",cell.costo_evento.text, [deporte valueForKeyPath:@"costo"]]];
    [cell.direccion setText:[NSString stringWithFormat:@"%@ %@",cell.direccion.text, [deporte valueForKeyPath:@"direccion"]]];
    
    return cell;
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *rutaSelect = [filasArray objectAtIndex:indexPath.row];
    [app() setRuta:rutaSelect];
    
    // Navigation logic may go here. Create and push another view controller.
    
    //EstablecimientoTabBarController *perfil = [self.storyboard instantiateViewControllerWithIdentifier:@"eventoTabBarController"];
    //app().tipoVista =@"evento";
    // ...
    // Pass the selected object to the new view controller.
    //[self.navigationController pushViewController:perfil animated:YES];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"¿Que acción quiere realizar?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ver Mapa", @"Ver en Vivo", @"Visitar Sitio Web", nil];
    [sheet showInView:self.view];
    
    
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

@end
