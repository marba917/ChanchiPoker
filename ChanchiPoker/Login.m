//
//  Login.m
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import "Login.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface Login ()

@end

@implementation Login
{
    
}

//----------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_indicador stopAnimating];
}

//----------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//----------------------------------------------------------------------------------------------------

- (IBAction)accionBotonEntrar:(id)sender
{
    [_indicador startAnimating];
    _vistaOpciones.alpha = 0;
    
    NSString *clave = _campoPassword.text;
    NSString *username = _campoUsuario.text;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager]; 
    NSDictionary *params = @{@"usuario": username,
                             @"password": clave};
    NSString *ruta = [NSString stringWithFormat:@"http://www.basculasjaramillo.com/AK/WS/loginUsuarios"];
    [manager POST:ruta parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        [_indicador stopAnimating];
        
        NSString *result = [responseObject objectForKey:@"id"];
         int idUsuario = [result intValue];
         if(idUsuario > 0)
         {
             [self performSegueWithIdentifier:@"loginCorrecto" sender:self];
         }
         else
         {
             [self mostrarAlerta:@"ERROR: usuario y contraseña inválidos."]; 
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [self mostrarAlerta:@"ERROR: revise su conexión e intente de nuevo"];
        _vistaOpciones.alpha = 1;
        [_indicador stopAnimating];
     }];
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

//--------------------------------------------------------------------------------------------------------------

- (void)mostrarAlerta:(NSString *)mensaje
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChanchiPoker" message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
}

//----------------------------------------------------------------------------------------------------







@end
