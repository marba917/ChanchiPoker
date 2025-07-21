//
//  Jugador.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/17/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "Jugador.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "ModeloJugador.h"
#import "UIImageView+WebCache.h"
#import "urlEncoding.h"
#import "ModeloRecompra2.h"
#import "CeldaJugador.h"
#import "AgregarConsignacion.h"


@interface Jugador ()

@end

@implementation Jugador
{
    ModeloJugador *mc;
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
    [self cargarinfo];
}

- (void)cargarinfo
{
    [_indicador startAnimating];
    
    NSString *strURL2 = [NSString stringWithFormat:@"http://206.189.195.96/chanchipoker/WS/jugadores/%@",_idJugador];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"cP+wxnsJC/Txg92xo9qxMoscQYplhVEtIRQTFV2MSUBLPBWhfdfpkQ==" forHTTPHeaderField:@"User-Agent"];
    //manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:strURL2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray* results = [responseObject objectForKey:@"results"];
         
         for(int i=0; i < results.count; i++)
         {
             mc = [[ModeloJugador alloc] init];
             
             NSDictionary *result = [results objectAtIndex:i];
             mc.id = [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]];
             mc.nombre = [NSString stringWithFormat:@"%@",[result objectForKey:@"nombre"]];
             mc.foto = [NSString stringWithFormat:@"%@",[result objectForKey:@"foto"]];
             mc.numjugadas = [NSString stringWithFormat:@"%@",[result objectForKey:@"numjugadas"]];
             mc.promediorecompras = [NSString stringWithFormat:@"%@",[result objectForKey:@"promediorecompras"]];
             mc.balance = [NSString stringWithFormat:@"%@",[result objectForKey:@"balance"]];
             
             
             
             int total = 0;
             NSArray* consignaciones = [result objectForKey:@"consignaciones"];
              
              [arreglo removeAllObjects];
              
              for(int i=0; i < consignaciones.count; i++)
              {
                  ModeloRecompra2 *mc = [[ModeloRecompra2 alloc] init];
                  
                  NSDictionary *result = [consignaciones objectAtIndex:i];
                  mc.id = [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]];
                  mc.id_jugador = [NSString stringWithFormat:@"%@",[result objectForKey:@"id_jugador"]];
                  mc.valor = [NSString stringWithFormat:@"%@",[result objectForKey:@"valor"]];
                  mc.hora = [NSString stringWithFormat:@"%@",[result objectForKey:@"fecha"]];
                  
                  NSLog(@"recompra id: %@",mc.id);
                  
                  total = total + [mc.valor integerValue];
                  
                  [arreglo addObject:mc];
              }
              
             NSString *va = [NSString stringWithFormat:@"%d",total];
             va = [self formatCurrencyWithString:va];
             va = [va stringByReplacingOccurrencesOfString:@"COP" withString:@"$"];
             _labelConsignaciones.text = [NSString stringWithFormat:@"Consignaciones:  %@",va];
             
              [_tabla reloadData];
              [_indicador stopAnimating];
             
             
             
             
         }
                  
         [_indicador stopAnimating];
         
         _labelNombre.text = mc.nombre;
         _labelJugadas.text = mc.numjugadas;
         _labelPromedio.text = [NSString stringWithFormat:@"$%@",mc.promediorecompras];
         NSString* newString = [mc.balance stringByReplacingOccurrencesOfString:@"-" withString:@""];
         _labelBalance.text = [NSString stringWithFormat:@"$%@",newString];
         
         int balance = [mc.balance intValue];
         
         if(balance > 0)
         {
             _labelBalance.textColor = [UIColor redColor];
         }
         else
         {
             _labelBalance.textColor = [UIColor greenColor];
         }
         
         // Here we use the new provided sd_setImageWithURL: method to load the web image
         NSString *rutaImagen = [mc.foto urlEncodeUsingEncoding:NSUTF8StringEncoding];
         [_foto sd_setImageWithURL:[NSURL URLWithString:rutaImagen] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
            //[self cargarRecompras];
        
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

- (void)mostrarAlerta:(NSString *)mensaje
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChanchiPoker" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
}

//--------------------------------------------------------------------------------------------------------------



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
    cell.contentView.backgroundColor = UIColor.lightGrayColor;
    
    return cell;
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
        
        NSString *strURL2 = [NSString stringWithFormat:@"http://206.189.195.96/chanchipoker/WS/borrarConsignacion/%@",mj.id];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager GET:strURL2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString* result = [responseObject objectForKey:@"respuesta"];
             
             if([result isEqualToString:@"OK"])
             {
                 [self cargarinfo];
             }
             else
             {
                 [self mostrarAlerta:@"Error: no se pudo borrar la consignacion"];
                 [self cargarinfo];
             }
             
             
             [_indicador stopAnimating];
         }
         
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"Error: no hay conexión a internet"];
            [self cargarinfo];
            [_indicador stopAnimating];
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

//---------------------------------------------------------------------------------------------
//SEGUES
//---------------------------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"consignar"])
    {
        AgregarConsignacion *vc = [segue destinationViewController];
        vc.idJugador = _idJugador;
    }
}






@end
