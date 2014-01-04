//
//  ViewStyle.h
//  Beautify
//
//  Created by Adrian Conlin on 02/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYStyle.h"

/**
 * Container for UIView level rendering properties.
 */
@interface BYViewStyle : BYStyle

@property float alpha;

@property UIColor<Optional> *tintColor;

@end