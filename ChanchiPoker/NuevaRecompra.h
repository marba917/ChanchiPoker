//
//  NuevaRecompra.h
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NuevaRecompra : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tabla;


- (IBAction)accion50mil:(id)sender;
- (IBAction)accion30mil:(id)sender;
- (IBAction)accion40mil:(id)sender;
- (IBAction)accion100mil:(id)sender;
- (IBAction)accion150mil:(id)sender;
- (IBAction)accionOtroValor:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *campoValor;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;


@property NSString *idJugada;



@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador2;
@property (weak, nonatomic) IBOutlet UIView *vistaOscura;
@property (weak, nonatomic) IBOutlet UIView *vistaOscuraWrapper;



@end
