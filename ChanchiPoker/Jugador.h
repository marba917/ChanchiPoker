//
//  Jugador.h
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/17/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Jugador : UIViewController

@property NSString *idJugador;

@property (weak, nonatomic) IBOutlet UIImageView *foto;

@property (weak, nonatomic) IBOutlet UILabel *labelNombre;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;


@property (weak, nonatomic) IBOutlet UILabel *labelJugadas;
@property (weak, nonatomic) IBOutlet UILabel *labelPromedio;
@property (weak, nonatomic) IBOutlet UILabel *labelBalance;

@property (weak, nonatomic) IBOutlet UITableView *tabla;

@property (weak, nonatomic) IBOutlet UILabel *labelConsignaciones;


@end
