//
//  Jugadas.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/15/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "Jugadas.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "ModeloJugada.h"
#import "Jugada.h"
#import "CeldaJugada.h"

@interface Jugadas ()

@end

@implementation Jugadas
{
    NSMutableArray *arreglo;
    
    ModeloJugada *jugadaSeleccionada;
}

//--------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arreglo = [[NSMutableArray alloc] init];
}

//--------------------------------------------------------------------------------------------------------------

-(void)viewDidAppear:(BOOL)animated
{
    [_indicador startAnimating];
    
    NSString *strURL2 = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/jugadas"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"cP+wxnsJC/Txg92xo9qxMoscQYplhVEtIRQTFV2MSUBLPBWhfdfpkQ==" forHTTPHeaderField:@"User-Agent"];
    //manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:strURL2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray* results = [responseObject objectForKey:@"results"];
         
         [arreglo removeAllObjects];
         
         for(int i=0; i < results.count; i++)
         {
             ModeloJugada *mc = [[ModeloJugada alloc] init];
             
             NSDictionary *result = [results objectAtIndex:i];
             mc.id = [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]];
             mc.nombre = [NSString stringWithFormat:@"%@",[result objectForKey:@"nombre"]];
             mc.fecha = [NSString stringWithFormat:@"%@",[result objectForKey:@"fecha"]];
             mc.cerrada = [NSString stringWithFormat:@"%@",[result objectForKey:@"cerrada"]];
             
             [arreglo addObject:mc];
         }
         
         [_tabla reloadData];
         
         [_indicador stopAnimating];
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [self mostrarAlerta:@"Error: no hay conexión a internet"];
     }];
}

//--------------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------------------

-(NSInteger) numberOfSectionsInTableView:(UITableView *)collectionView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"cantidad: %lu",(unsigned long)arreglo.count);
    return arreglo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    CeldaJugada *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil)
    {
        cell = [[CeldaJugada alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ModeloJugada *mj = [arreglo objectAtIndex:indexPath.row];
    
    NSString *dateString = mj.fecha;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"EEEE, MMM d, yyyy, hh:mm a"];
    NSString* finalDateString = [format stringFromDate:date];
    
    cell.labelNombre.text = [NSString stringWithFormat:@"%@ - %@", mj.id, mj.nombre];
    cell.labelFecha.text = [NSString stringWithFormat:@"%@", finalDateString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModeloJugada *mj = [arreglo objectAtIndex:indexPath.row];
    
    jugadaSeleccionada = mj;
    
    [self performSegueWithIdentifier:@"verJugada" sender:self];
}

//--------------------------------------------------------------------------------------------------------------

- (void)mostrarAlerta:(NSString *)mensaje
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChanchiPoker" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
}

//---------------------------------------------------------------------------------------------
//SEGUES
//---------------------------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"verJugada"])
    {
        Jugada *vc = [segue destinationViewController];
        vc.jugadaSeleccionada = jugadaSeleccionada; 
    }
}



@end
