//
//  Recompras.h
//  ChanchiPoker
//
//  Created by TAKTIL INC on 5/16/16.
//  Copyright © 2016 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Recompras : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tabla;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;


@property NSString *idJugada;
@property NSString *idJugador;


@end
