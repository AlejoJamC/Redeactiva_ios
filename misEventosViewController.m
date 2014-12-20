//
//  misEventosViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "misEventosViewController.h"
#import "eventoTableViewCell.h"

@interface misEventosViewController ()

@end

@implementation misEventosViewController

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
    filasArray = [NSMutableArray array];
    _currentPage = 1;
    _cargando = false;
    _noMoreResultsAvail = false;
}

- (void) viewDidAppear:(BOOL)animated {
    self.tabla_rutinas.dataSource = self;
    [self cargarEventos];
    
}

-(void)cargarEventos{
    NSString *url =
    [NSString stringWithFormat:@"%@/containers/getcontainers/calendario/%i",app().urlServicio, _currentPage];
    
    
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if([ filasArray count] ==0){
        return 0;
    }
    else {
        return [filasArray count]+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"cellEv";
    
    eventoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[eventoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (filasArray.count != 0) {
        if(indexPath.row <[filasArray count]){
            NSDictionary *deporte = [filasArray objectAtIndex:indexPath.row];
        
            [cell.titulo_evento setText:[NSString stringWithFormat:@"Titulo del Evento: %@", [deporte valueForKeyPath:@"evento"]]];
            [cell.telefonos setText:[NSString stringWithFormat:@"Tipo: %@", [deporte valueForKeyPath:@"tipo"]]];
            [cell.horario setText:[NSString stringWithFormat:@"Horario: Inicia: %@ - Termina: %@", [deporte valueForKeyPath:@"fechainicio"], [deporte valueForKeyPath:@"fechafinal"]]];
            [cell.costo_evento setText:[NSString stringWithFormat:@"Entidad %@", [deporte valueForKeyPath:@"entidad"]]];
            [cell.direccion setText:[NSString stringWithFormat:@"%@", [deporte valueForKeyPath:@"descripciondelevento"]]];
            
            [cell.cargando stopAnimating];
            cell.cargando.hidden = true;
        }else{
            if (!_noMoreResultsAvail) {
                cell.titulo_evento.text=nil;
                cell.telefonos.text=nil;
                cell.horario.text=nil;
                cell.costo_evento.text = nil;
                cell.direccion.text = nil;
                
                [cell.cargando startAnimating];
                cell.cargando.hidden = false;
            }
            else{
                cell.titulo_evento.text=nil;
                cell.telefonos.text=nil;
                cell.horario.text=@"No hay más deportes para visualizar";
                cell.costo_evento.text = nil;
                cell.direccion.text = nil;
                
                [cell.cargando stopAnimating];
                cell.cargando.hidden = true;
            
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
            [self performSelector:@selector(cargarEventos) withObject:nil afterDelay:1];
            
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < [filasArray count]){
        NSDictionary *rutaSelect = [filasArray objectAtIndex:indexPath.row];
        [app() setRuta:rutaSelect];
        
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"¿Que acción quiere realizar?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Visitar Sitio Web", @"Contactar", nil];
        [sheet showInView:self.view];
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if ([[[app().ruta valueForKeyPath:@"paginaweb"] stringByTrimmingCharactersInSet:
                                                           [NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                                message:@"Lo sentimos no hay un sitio web disponible para este evento"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[app().ruta valueForKeyPath:@"paginaweb"]]];
            }
            
            break;
            
        case 1:
            
            if ([[[app().ruta valueForKeyPath:@"contacto"] stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                                message:@"Lo sentimos no hay un email valido para contactar con los administradores de este evento"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",[[app().ruta valueForKeyPath:@"contacto"] stringByTrimmingCharactersInSet:
                                                                                                                         [NSCharacterSet whitespaceCharacterSet]]]]];
            }
            
            break;
            
        default:
            break;
    }
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
