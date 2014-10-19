//
//  Game.h
//  Monoku
//
//  Created by Monika Pawluczuk on 08.06.2014.
//  Copyright (c) 2014 Monika Pawluczuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "SudokuSquare.h"
@interface Game : NSObject
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger currentSquare;
@property (strong, nonatomic) Board *sudokuBoard;
-(NSInteger)valueAtSquare:(NSInteger)index;
-(BOOL)isPredefined:(NSInteger)index;
-(BOOL)enterValue:(NSInteger)value;
-(BOOL)gameOver;
@end
