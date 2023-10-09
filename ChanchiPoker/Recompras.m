//
//  Recompras.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 5/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "Recompras.h"
#import <AFNetworking.h>
#import "ModeloRecompra2.h"
#import "CeldaJugador.h"

@interface Recompras ()

@end

@implementation Recompras
{
    NSMutableArray *arreglo;  
}

//--------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Se cambia el texto del boton back
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    
    arreglo = [[NSMutableArray alloc] init];
}

//--------------------------------------------------------------------------------------------------------------

-(void)viewDidAppear:(BOOL)animated
{
    [self cargarRecompras];
}

-(void)cargarRecompras
{
    [_indicador startAnimating];
    
    NSString *strURL2 = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recomprasjugador/%@/%@",_idJugada,_idJugador];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:strURL2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray* results = [responseObject objectForKey:@"results"];
         
         [arreglo removeAllObjects];
         
         for(int i=0; i < results.count; i++)
         {
             ModeloRecompra2 *mc = [[ModeloRecompra2 alloc] init];
             
             NSDictionary *result = [results objectAtIndex:i];
             mc.id = [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]];
             mc.id_jugador = [NSString stringWithFormat:@"%@",[result objectForKey:@"id_jugador"]];
             mc.id_jugada = [NSString stringWithFormat:@"%@",[result objectForKey:@"id_jugada"]];
             mc.valor = [NSString stringWithFormat:@"%@",[result objectForKey:@"valor"]];
             mc.hora = [NSString stringWithFormat:@"%@",[result objectForKey:@"hora"]];
             
             NSLog(@"recompra id: %@",mc.id);
             
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

- (void)mostrarAlerta:(NSString *)mensaje
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChanchiPoker" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
}

//--------------------------------------------------------------------------------------------------------------

-(NSInteger) numberOfSectionsInTableView:(UITableView *)collectionView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arreglo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"celdaJugador";
    
    CeldaJugador *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil)
    {
        cell = [[CeldaJugador alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ModeloRecompra2 *mj = [arreglo objectAtIndex:indexPath.row];
    
    cell.fechaRecompra.text = mj.hora;
    
    NSString* newString = [mj.valor stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *vv = [self formatCurrencyWithString:newString];
    vv = [vv stringByReplacingOccurrencesOfString:@"COP" withString:@"$"];
    
    cell.valorRecompra.text = vv;
    
    int valor = [mj.valor intValue];
    
    if(valor < 0)
    {
        cell.valorRecompra.textColor = [UIColor greenColor];
    }
    else
    {
        cell.valorRecompra.textColor = [UIColor redColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ModeloRecompra2 *mj = [arreglo objectAtIndex:indexPath.row];
        
        [_indicador startAnimating];
        
        NSString *strURL2 = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/borrarRecompra/%@",mj.id];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager GET:strURL2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString* result = [responseObject objectForKey:@"respuesta"];
             
             if([result isEqualToString:@"OK"])
             {
                 [self cargarRecompras];
             }
             else
             {
                 [self mostrarAlerta:@"Error: no se pudo borrar la recompra"];
             }
             
             
             [_indicador stopAnimating];
         }
         
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"Error: no hay conexión a internet"];
         }];
        
        
    }
}

//--------------------------------------------------------------------------------------------------------------

- (NSString*) formatCurrencyWithString: (NSString *) string
{
    // alloc formatter
    NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
    
    [currencyStyle setMaximumFractionDigits:0];
    
    // set options.
    [currencyStyle setFormatterBehavior:NSNumberFormatterBehavior10_4];
    
    // reset style to no style for converting string to number.
    [currencyStyle setNumberStyle:NSNumberFormatterNoStyle];
    
    //create number from string
    NSNumber * balance = [currencyStyle numberFromString:string];
    
    
    //now set to currency format
    [currencyStyle setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // get formatted string
    NSString* formatted = [currencyStyle stringFromNumber:balance];
    
    //return formatted string
    return formatted;
}

//--------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------------------

@end
