//
//  Jugada.h
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeloJugada.h"

@interface Jugada : UIViewController

@property ModeloJugada *jugadaSeleccionada;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;

@property (weak, nonatomic) IBOutlet UITableView *tabla;

@property (weak, nonatomic) IBOutlet UILabel *labelPoteTotal;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *botonMas;



@end
