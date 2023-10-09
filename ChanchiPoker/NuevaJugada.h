//
//  NuevaJugada.h
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/15/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NuevaJugada : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *campoNombre;

- (IBAction)accionBotonCrear:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;

@property (weak, nonatomic) IBOutlet UIButton *botonCrear;

@end
