//
//  Game.m
//  Monoku
//
//  Created by Monika Pawluczuk on 08.06.2014.
//  Copyright (c) 2014 Monika Pawluczuk. All rights reserved.
//

#import "Game.h"
@interface Game()
@end
static int bonus = 10;
static int penalty = 3;
@implementation Game
- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_sudokuBoard)
        {
            _sudokuBoard = [[Board alloc] init];
        }
    }
    return self;
}

-(NSInteger)valueAtSquare:(NSInteger)index
{
    SudokuSquare *square = [_sudokuBoard squareOnIndex:index];
    return square.value;
}

-(BOOL)isPredefined:(NSInteger)index
{
    SudokuSquare *square = [_sudokuBoard squareOnIndex:index];
    return [square isPredefined];
}

-(BOOL)enterValue:(NSInteger)value
{
    NSInteger properValue = [self valueAtSquare:_currentSquare];
    if (value < 1 || value > 9 || value != properValue)
    {
        _score -= (_score == 0) ? 0 : penalty;
        return false;
    }
    SudokuSquare *square = [_sudokuBoard squareOnIndex:_currentSquare];
    square.predefined = true;
    _score += bonus;
    return true;
    
}

-(BOOL)gameOver
{
    return ([_sudokuBoard countUnpredefinedSquares] == 0) ?
        true : false;
}
@end
