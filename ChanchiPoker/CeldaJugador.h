//
//  CeldaJugador.h
//  ChanchiPoker
//
//  Created by TAKTIL INC on 2/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CeldaJugador : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *labelNombre;
@property (weak, nonatomic) IBOutlet UILabel *labelValor;

@property (weak, nonatomic) IBOutlet UIImageView *foto;

@property (weak, nonatomic) IBOutlet UILabel *labelCompro;

@property (weak, nonatomic) IBOutlet UILabel *labelPromedio;

@property (weak, nonatomic) IBOutlet UILabel *labelJugadas;


@property (weak, nonatomic) IBOutlet UILabel *valorRecompra;
@property (weak, nonatomic) IBOutlet UILabel *fechaRecompra;


@end
