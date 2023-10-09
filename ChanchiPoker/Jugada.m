//
//  Jugada.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "Jugada.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "ModeloJugador.h"
#import "ModeloRecompra.h"
#import "CeldaJugador.h"
#import "NuevaRecompra.h"
#import "UIImageView+WebCache.h"
#import "urlEncoding.h"
#import "Recompras.h"

@interface Jugada ()

@end

@implementation Jugada
{
    NSMutableArray *arreglo;
    
    NSString *idJugadorSeleccionado;
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
    
    if([_jugadaSeleccionada.cerrada isEqualToString:@"1"])
    {
        _botonMas.enabled = NO; 
    }
    
    idJugadorSeleccionado = @"";
}

//--------------------------------------------------------------------------------------------------------------

-(void)viewDidAppear:(BOOL)animated
{
    [_indicador startAnimating]; 
    
    NSString *strURL2 = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras/%@",_jugadaSeleccionada.id];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"cP+wxnsJC/Txg92xo9qxMoscQYplhVEtIRQTFV2MSUBLPBWhfdfpkQ==" forHTTPHeaderField:@"User-Agent"];
    //manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:strURL2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray* results = [responseObject objectForKey:@"results"];
         
         [arreglo removeAllObjects];
         
         int total = 0;
         
         for(int i=0; i < results.count; i++)
         {
             ModeloRecompra *mc = [[ModeloRecompra alloc] init];
             
             NSDictionary *result = [results objectAtIndex:i];
             mc.id_jugador = [NSString stringWithFormat:@"%@",[result objectForKey:@"id_jugador"]];
             mc.nombre_jugador = [NSString stringWithFormat:@"%@",[result objectForKey:@"nombre_jugador"]];
             mc.valor = [NSString stringWithFormat:@"%@",[result objectForKey:@"valor"]];
             mc.valor_compras = [NSString stringWithFormat:@"%@",[result objectForKey:@"valor_compras"]];
             mc.foto = [NSString stringWithFormat:@"%@",[result objectForKey:@"foto"]];
             
             [arreglo addObject:mc];
             
             total = total + [mc.valor_compras intValue]; 
         }
         
         [_tabla reloadData];
         
         [_indicador stopAnimating];
         
         NSString *va = [NSString stringWithFormat:@"%d",total];
         
         va = [self formatCurrencyWithString:va];
         
         va = [va stringByReplacingOccurrencesOfString:@"COP" withString:@"$"];
         
         _labelPoteTotal.text = [NSString stringWithFormat:@"Pote total:    %@",va];
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
    static NSString *cellId = @"celdaJugador";
    
    CeldaJugador *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil)
    {
        cell = [[CeldaJugador alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ModeloRecompra *mj = [arreglo objectAtIndex:indexPath.row];
    
    cell.labelNombre.text = mj.nombre_jugador;
    
    NSString* newString = [mj.valor stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString* newString2 = [mj.valor_compras stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *vv = [self formatCurrencyWithString:newString];
    vv = [vv stringByReplacingOccurrencesOfString:@"COP" withString:@"$"];
    
    NSString *vv2 = [self formatCurrencyWithString:newString2];
    vv2 = [vv2 stringByReplacingOccurrencesOfString:@"COP" withString:@"$"];
    
    
    
    
    cell.labelValor.text = vv;
    cell.labelCompro.text = vv2;
    
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    NSString *rutaImagen = [mj.foto urlEncodeUsingEncoding:NSUTF8StringEncoding];
    [cell.foto sd_setImageWithURL:[NSURL URLWithString:rutaImagen] placeholderImage:[UIImage imageNamed:@"placeholder.png"]]; 
    
    
    int valor = [mj.valor intValue];
    
    if(valor < 0)
    {
        cell.labelValor.textColor = [UIColor greenColor];
    }
    else
    {
        cell.labelValor.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selecciona celda");
    ModeloRecompra *mj = [arreglo objectAtIndex:indexPath.row];
    
    idJugadorSeleccionado = mj.id_jugador;
    
    [self performSegueWithIdentifier:@"verRecompras" sender:self];
}

//--------------------------------------------------------------------------------------------------------------

- (void)mostrarAlerta:(NSString *)mensaje
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChanchiPoker" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
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

//---------------------------------------------------------------------------------------------
//SEGUES
//---------------------------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"nuevaRecompra"])
    {
        NuevaRecompra *vc = [segue destinationViewController];
        vc.idJugada = _jugadaSeleccionada.id;
    }
    
    if ([[segue identifier] isEqualToString:@"verRecompras"])
    {
        Recompras *vc = [segue destinationViewController];
        vc.idJugada = _jugadaSeleccionada.id;
        vc.idJugador = idJugadorSeleccionado;
    }
}

@end
