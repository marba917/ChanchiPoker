//
//  AdicionarJugador.m
//  ChanchiPoker
//
//  Created by Marba's Macbook on 9/9/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "AdicionarJugador.h"
#import <AFNetworking/AFNetworking.h>

@interface AdicionarJugador ()

@end

//--------------------------------------------------------------------------------------------------------------

@implementation AdicionarJugador
{
    
}

//--------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//--------------------------------------------------------------------------------------------------------------

- (IBAction)accionBotonAgregar:(id)sender
{
    if([_campoNombre.text isEqualToString:@""])
    {
        [self mostrarAlerta:@"Ingrese el nombre de la jugada..."];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"nombre": _campoNombre.text};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/jugadores"];
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
                 [self mostrarAlerta:@"ERROR: no se pudo crear el jugador."];
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

- (void)mostrarAlerta:(NSString *)mensaje
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChanchiPoker" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
}

//--------------------------------------------------------------------------------------------------------------











@end
