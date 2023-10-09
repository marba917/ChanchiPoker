//
//  Login.h
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *campoUsuario;


@property (weak, nonatomic) IBOutlet UITextField *campoPassword;


- (IBAction)accionBotonEntrar:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *vistaOpciones;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;


@end
