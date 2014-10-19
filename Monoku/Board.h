//
//  Board.h
//  Monoku
//
//  Created by Monika Pawluczuk on 08.06.2014.
//  Copyright (c) 2014 Monika Pawluczuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SudokuSquare.h"
@interface Board : NSObject
@property NSMutableArray *squares;
- (SudokuSquare*)squareOnIndex:(NSInteger)index;
- (NSInteger)countUnpredefinedSquares;
@end
