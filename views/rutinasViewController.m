//
//  rutinasViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 20/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "rutinasViewController.h"
#import "rutinaTableViewCell.h"

@interface rutinasViewController ()

@end

@implementation rutinasViewController

@synthesize responseData = _responseData, tabla_rutinas = _tabla_rutinas;

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
    urlServicioRutinas = [NSString stringWithFormat:@"http://190.248.53.209/redeactiva/rutina.php"];
    work = false;
}

- (void) viewDidAppear:(BOOL)animated {
    self.tabla_rutinas.dataSource = self;
    work = true;
    [self cargarRutinas];
    
}

- (void)viewDidUnload {
    [self setTabla_rutinas:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cargarRutinas{
    NSLog(@"viewdidload");
    filasArray = [[NSMutableArray alloc] init];
    self.responseData = [NSMutableData data];
    NSURL *aUrl = [NSURL URLWithString:urlServicioRutinas];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"accion=rutinas&userId=%@", [app() userid]];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                                 delegate:self];

}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    work = true;
    if (buttonIndex == 0) {
        //Modificar
        [self modificar];
    } else if (buttonIndex == 1) {
        //eliminar
        [self eliminar];
    }
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

-(void)eliminar{
    
    NSString *url =
    [NSString stringWithFormat:@"%@?method_ws=eliminarRuta&objectId=%@",urlServicioRutinas, [app().ruta valueForKey:@"objectId"]];
    
    
    NSURL *dirUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", dirUrl);
    
    
    NSData * data=[NSData dataWithContentsOfURL:dirUrl];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                    message:@"Su Rutina ha sido eliminada con éxito"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [self cargarRutinas];
}

-(void)modificar{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"actualizarRutina"] animated:YES];
    work = false;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    
    NSError *myError = nil;
    NSDictionary *datos = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    for(id key in datos) {
        filasArray = [datos objectForKey:key];
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
    
    return [filasArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        static NSString *CellIdentifier = @"cellC";
        
        rutinaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[rutinaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        NSDictionary *rutina = [filasArray objectAtIndex:indexPath.row];
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
        NSDate *d = [dateFormatter dateFromString:[rutina valueForKeyPath:@"hora"]];
    
        [dateFormatter setDateFormat:@"h:mm a"];
        NSString *dateString = [dateFormatter stringFromDate:d];
    
        [cell.titulo setText:[NSString stringWithFormat:@"%@ - a las %@",[rutina valueForKeyPath:@"titulo_rutina"], dateString]];
        [cell.dias setText:[rutina valueForKeyPath:@"dias"]];
        work = false;
        return cell;
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (work == false) {
        
        NSDictionary *rutaSelect = [filasArray objectAtIndex:indexPath.row];
        [app() setRuta:rutaSelect];
        
        // Navigation logic may go here. Create and push another view controller.
        
        //EstablecimientoTabBarController *perfil = [self.storyboard instantiateViewControllerWithIdentifier:@"eventoTabBarController"];
        //app().tipoVista =@"evento";
        // ...
        // Pass the selected object to the new view controller.
        //[self.navigationController pushViewController:perfil animated:YES];
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"¿Que acción quiere realizar?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Modificar esta rutina",@"Eliminar esta rutina", nil];
        [sheet showInView:self.view];
    }
    
    
}

@end
