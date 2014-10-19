//
//  SudokuSquare.m
//  Monoku
//
//  Created by Monika Pawluczuk on 03.06.2014.
//  Copyright (c) 2014 Monika Pawluczuk. All rights reserved.
//

#import "SudokuSquare.h"

@implementation SudokuSquare
-(instancetype)initWithIndex:(NSInteger)index value:(NSInteger)value
{
	self = [super init];
    if (self) {
		_index = (index < [SudokuSquare maxIndex]) ? index : -1;
		_sector = [self sectorFromIndex:index];
		_column = [self columnFromIndex:index];
		_row = [self rowFromIndex:index];
		_predefined = false;
		_value = value;
	}
	
	return self;
	
}
-(NSInteger)sectorFromIndex: (NSInteger)index
{
	NSInteger column, row;
	NSInteger squareColumn = [self columnFromIndex:index];
	NSInteger squareRow = [self rowFromIndex:index];
	
	if (squareColumn < 3) column = 0;
	else if (squareColumn > 2 && squareColumn < 6) column = 1;
	else if (squareColumn > 5 && squareColumn < 9) column = 2;
	
	if (squareRow < 3) row = 0;
	else if (squareRow > 2 && squareRow < 6) row = 1;
	else if (squareRow > 5 && squareRow < 9) row = 2;
	
	return 3*row + column;
}

-(NSInteger)columnFromIndex: (NSInteger)index
{
	return index % 9;
}

-(NSInteger)rowFromIndex: (NSInteger)index
{
	return index / 9;
}

-(void)setValue:(NSInteger)value
{
	if (value > 0 && value < 10)
		_value = value;
}

+ (NSInteger)maxIndex
{
	return 81;
}

+ (NSInteger) maxValue
{
	return 9;
}
@end
