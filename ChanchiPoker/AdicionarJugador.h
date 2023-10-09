//
//  AdicionarJugador.h
//  ChanchiPoker
//
//  Created by Marba's Macbook on 9/9/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdicionarJugador : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *campoNombre;

@property (weak, nonatomic) IBOutlet UIButton *botonAgregar;


- (IBAction)accionBotonAgregar:(id)sender;


@end
