//
//  NuevaJugada.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/15/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "NuevaJugada.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface NuevaJugada ()

@end

@implementation NuevaJugada
{
    
}

//--------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_indicador stopAnimating];
}

//--------------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------------------

- (IBAction)accionBotonCrear:(id)sender
{
    [_indicador startAnimating];
    _botonCrear.alpha = 0;
    _campoNombre.alpha = 0;
    
    if([_campoNombre.text isEqualToString:@""])
    {
        [self mostrarAlerta:@"Ingrese el nombre de la jugada..."];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"nombre": _campoNombre.text};
        NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/jugadas"];
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
                 [self mostrarAlerta:@"ERROR: no se pudo crear la jugada."];
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
            _botonCrear.alpha = 1;
            _campoNombre.alpha = 1;
            [_indicador stopAnimating];
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
