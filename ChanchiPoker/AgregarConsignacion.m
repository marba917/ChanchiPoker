//
//  AgregarConsignacion.m
//  ChanchiPoker
//
//  Created by Mario Jaramillo on 5/21/20.
//  Copyright © 2020 TAKTIL INC. All rights reserved.
//

#import "AgregarConsignacion.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface AgregarConsignacion ()

@end

@implementation AgregarConsignacion
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_indicador stopAnimating];
}

- (IBAction)accionBotonAgregar:(id)sender {
    
    if([_campoTexto.text isEqualToString:@""])
    {
        [self mostrarAlerta:@"Ingrese el valor de la consignación"];
    }
    else
    {
        [_indicador startAnimating];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"id_jugador": _idJugador,
                                 @"valor": _campoTexto.text};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/consignacion"];
        [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            [_indicador stopAnimating];
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
            [_indicador stopAnimating];
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


@end
