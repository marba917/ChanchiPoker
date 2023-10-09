//
//  NuevaRecompra.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "NuevaRecompra.h"
#import "ModeloJugador.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface NuevaRecompra ()

@end

@implementation NuevaRecompra
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
    
    _vistaOscura.alpha = 0.8;
    
    [self ocultarVistaOscura];
}

//--------------------------------------------------------------------------------------------------------------

-(void)viewDidAppear:(BOOL)animated
{
    [_indicador startAnimating];
    
    NSString *strURL2 = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/jugadores"];
    
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
             ModeloJugador *mc = [[ModeloJugador alloc] init];
             
             NSDictionary *result = [results objectAtIndex:i];
             mc.id = [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]];
             mc.nombre = [NSString stringWithFormat:@"%@",[result objectForKey:@"nombre"]];
             
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------------------

- (IBAction)accion50mil:(id)sender
{
    if([idJugador isEqualToString:@""])
    {
        [self mostrarAlerta:@"Seleccione un jugador de la lista..."];
    }
    else
    {
        [self mostrarVistaOscura];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": idJugador,
                                 @"id_jugada": _idJugada,
                                 @"valor": @"50000"};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *result = [responseObject objectForKey:@"id"];
             int idReferido = [result intValue];
             if(idReferido > 0)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [self mostrarAlerta:@"ERROR: no se pudo crear la recompra."];
                 [self ocultarVistaOscura];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
            [self ocultarVistaOscura];
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
         }];
    }
}

//--------------------------------------------------------------------------------------------------------------

- (IBAction)accion30mil:(id)sender
{
    if([idJugador isEqualToString:@""])
    {
        [self mostrarAlerta:@"Seleccione un jugador de la lista..."];
    }
    else
    {
        [self mostrarVistaOscura];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": idJugador,
                                 @"id_jugada": _idJugada,
                                 @"valor": @"30000"};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *result = [responseObject objectForKey:@"id"];
             int idReferido = [result intValue];
             if(idReferido > 0)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [self mostrarAlerta:@"ERROR: no se pudo crear la recompra."];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
         }];
    }
}

//--------------------------------------------------------------------------------------------------------------

- (IBAction)accion40mil:(id)sender
{
    if([idJugador isEqualToString:@""])
    {
        [self mostrarAlerta:@"Seleccione un jugador de la lista..."];
    }
    else
    {
        [self mostrarVistaOscura];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": idJugador,
                                 @"id_jugada": _idJugada,
                                 @"valor": @"40000"};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *result = [responseObject objectForKey:@"id"];
             int idReferido = [result intValue];
             if(idReferido > 0)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [self mostrarAlerta:@"ERROR: no se pudo crear la recompra."];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
         }];
    }
}

- (IBAction)accion10mil:(id)sender {
    
    if([idJugador isEqualToString:@""])
    {
        [self mostrarAlerta:@"Seleccione un jugador de la lista..."];
    }
    else
    {
        [self mostrarVistaOscura];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": idJugador,
                                 @"id_jugada": _idJugada,
                                 @"valor": @"10000"};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *result = [responseObject objectForKey:@"id"];
             int idReferido = [result intValue];
             if(idReferido > 0)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [self mostrarAlerta:@"ERROR: no se pudo crear la recompra."];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
         }];
    }
}

- (IBAction)accion15mil:(id)sender {
    
    if([idJugador isEqualToString:@""])
    {
        [self mostrarAlerta:@"Seleccione un jugador de la lista..."];
    }
    else
    {
        [self mostrarVistaOscura];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": idJugador,
                                 @"id_jugada": _idJugada,
                                 @"valor": @"15000"};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *result = [responseObject objectForKey:@"id"];
             int idReferido = [result intValue];
             if(idReferido > 0)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [self mostrarAlerta:@"ERROR: no se pudo crear la recompra."];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
         }];
    }
}

- (IBAction)accion25mil:(id)sender {
    
    if([idJugador isEqualToString:@""])
    {
        [self mostrarAlerta:@"Seleccione un jugador de la lista..."];
    }
    else
    {
        [self mostrarVistaOscura];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": idJugador,
                                 @"id_jugada": _idJugada,
                                 @"valor": @"25000"};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *result = [responseObject objectForKey:@"id"];
             int idReferido = [result intValue];
             if(idReferido > 0)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [self mostrarAlerta:@"ERROR: no se pudo crear la recompra."];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
         }];
    }
}





//--------------------------------------------------------------------------------------------------------------

- (IBAction)accionOtroValor:(id)sender
{
    if([idJugador isEqualToString:@""])
    {
        [self mostrarAlerta:@"Seleccione un jugador de la lista..."];
    }
    else if([_campoValor.text isEqualToString:@""])
    {
        [self mostrarAlerta:@"Ingrese el valor de la recompra"];
    }
    else
    {
        [self mostrarVistaOscura];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": idJugador,
                                 @"id_jugada": _idJugada,
                                 @"valor": _campoValor.text};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/recompras"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *result = [responseObject objectForKey:@"id"];
             int idReferido = [result intValue];
             if(idReferido > 0)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [self mostrarAlerta:@"ERROR: no se pudo crear la recompra."];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
         }];
    }
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ModeloJugador *mj = [arreglo objectAtIndex:indexPath.row];
    
    cell.textLabel.text = mj.nombre; 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModeloJugador *mj = [arreglo objectAtIndex:indexPath.row];
    idJugador = mj.id;
}

//--------------------------------------------------------------------------------------------------------------

- (void)mostrarAlerta:(NSString *)mensaje
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChanchiPoker" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
}

//----------------------------------------------------------------------------------------------------
//Estos dos metodos ocultan el teclado en pantalla
//----------------------------------------------------------------------------------------------------
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
    
    [UIView beginAnimations:@"animationOff" context:NULL];
    [UIView setAnimationDuration:0.25f];
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [UIView commitAnimations];
}

//----------------------------------------------------------------------------------------------------
//Este metodo mueve la vista cuando sale el teclado
//----------------------------------------------------------------------------------------------------
- (IBAction)keyboardDidShow:(id)sender
{
    [UIView beginAnimations:@"animationOff" context:NULL];
    [UIView setAnimationDuration:0.4f];
    [self.view setFrame:CGRectMake(0,-140,self.view.frame.size.width,self.view.frame.size.height)];
    [UIView commitAnimations];
}


//----------------------------------------------------------------------------------------------------
//Estos dos metodos ocultan el teclado en pantalla
//----------------------------------------------------------------------------------------------------
- (IBAction)testbutton:(id)sender {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_campoValor resignFirstResponder];
    
    [UIView beginAnimations:@"animationOff" context:NULL];
    [UIView setAnimationDuration:0.4f];
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [UIView commitAnimations];
}



-(void)mostrarVistaOscura
{
    _vistaOscuraWrapper.hidden = NO;
}

-(void)ocultarVistaOscura
{
    _vistaOscuraWrapper.hidden = YES;
}





@end
