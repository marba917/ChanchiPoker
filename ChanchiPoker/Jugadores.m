//
//  Jugadores.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "Jugadores.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "ModeloJugador.h"
#import "CeldaJugador.h"
#import "UIImageView+WebCache.h"
#import "urlEncoding.h"
#import "Jugador.h"

@interface Jugadores ()

@end

@implementation Jugadores
{
    NSMutableArray *arreglo;
    NSString *idJugador;
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
    
    idJugador = @"";
}

//--------------------------------------------------------------------------------------------------------------

-(void)viewDidAppear:(BOOL)animated
{
    [_indicador startAnimating];
    
    NSString *strURL2 = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/jugadoresquejuegan"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"cP+wxnsJC/Txg92xo9qxMoscQYplhVEtIRQTFV2MSUBLPBWhfdfpkQ==" forHTTPHeaderField:@"User-Agent"];
    //manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:strURL2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray* results = [responseObject objectForKey:@"results"];
        NSString *total = [responseObject objectForKey:@"total"];
         
         [arreglo removeAllObjects];
                 
         for(int i=0; i < results.count; i++)
         {
             ModeloJugador *mc = [[ModeloJugador alloc] init];
             
             NSDictionary *result = [results objectAtIndex:i];
             mc.id = [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]];
             mc.nombre = [NSString stringWithFormat:@"%@",[result objectForKey:@"nombre"]];
             mc.foto = [NSString stringWithFormat:@"%@",[result objectForKey:@"foto"]];
             mc.balance = [NSString stringWithFormat:@"%@",[result objectForKey:@"balance"]];
             mc.numjugadas = [NSString stringWithFormat:@"%@",[result objectForKey:@"numjugadas"]];
             mc.promediorecompras = [NSString stringWithFormat:@"%@",[result objectForKey:@"banco"]];
                          
             [arreglo addObject:mc];
         }
                
        _labelTotal.text = [NSString stringWithFormat:@"Total en Banco: $%@",total];
         [_tabla reloadData];
         [_indicador stopAnimating];
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [self mostrarAlerta:@"Error: no hay conexión a internet"];
     }];
    
    [_tabla setContentOffset:CGPointZero animated:YES];
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
    
    ModeloJugador *mj = [arreglo objectAtIndex:indexPath.row];
    
    cell.labelNombre.text = mj.nombre;
    cell.labelPromedio.text = [NSString stringWithFormat:@"$%@",mj.promediorecompras];
    cell.labelValor.text = mj.balance;
    cell.labelJugadas.text = mj.numjugadas;
    
    NSString* newString = [mj.balance stringByReplacingOccurrencesOfString:@"-" withString:@""];
    cell.labelValor.text = [NSString stringWithFormat:@"$%@",newString];
    
    int balance = [mj.balance intValue];
    
    if(balance > 0)
    {
        cell.labelValor.textColor = [UIColor redColor];
    }
    else
    {
        cell.labelValor.textColor = [UIColor greenColor];
    }
    
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    NSString *rutaImagen = [mj.foto urlEncodeUsingEncoding:NSUTF8StringEncoding];
    [cell.foto sd_setImageWithURL:[NSURL URLWithString:rutaImagen] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell; 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModeloJugador *mj = [arreglo objectAtIndex:indexPath.row];
    idJugador = mj.id;
    
    [self performSegueWithIdentifier:@"verJugador" sender:self];
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
    if ([[segue identifier] isEqualToString:@"verJugador"])
    {
        Jugador *vc = [segue destinationViewController];
        vc.idJugador = idJugador;
    }
}











@end
