//
//  AgregarConsignacion.h
//  ChanchiPoker
//
//  Created by Mario Jaramillo on 5/21/20.
//  Copyright © 2020 TAKTIL INC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgregarConsignacion : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *campoTexto;

@property (weak, nonatomic) IBOutlet UIButton *botonAgregar;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;

@property NSString *idJugador;

@end

NS_ASSUME_NONNULL_END
