//
//  Board.m
//  Monoku
//
//  Created by Monika Pawluczuk on 08.06.2014.
//  Copyright (c) 2014 Monika Pawluczuk. All rights reserved.
//

#import "Board.h"
#include <iostream>
#include <cstdlib>
#include <algorithm>
#include <random>
#include <set>

@implementation Board
static int rowsPredefined = 50;
using namespace std;
int board[81];

- (instancetype)init
{
    self = [super init];
    if (self) {
        srand(time(NULL));
        
        int row = 0;
        for(int i=0; i<9; i++)
            zeroRow(i);
        while(!fill(row));
        if (!isBoardValid())
            return nil;
        
        [self fillSquares];
        
    }
    return self;
}

-(NSInteger)countUnpredefinedSquares
{
    NSInteger counter = 0;
    for (SudokuSquare* sudokuSquare in _squares)
	{
        if (sudokuSquare.predefined == false) counter++;
    }
    return counter;
}

- (SudokuSquare*)squareOnIndex:(NSInteger)index
{
	for (SudokuSquare* sudokuSquare in _squares)
	{
		if ( sudokuSquare.index == index) return sudokuSquare;
	}
	return nil;
}

- (void)fillSquares
{
    _squares = [[NSMutableArray alloc] init];
    for (int index = 0; index < 81; index++)
    {
        SudokuSquare *square = [[SudokuSquare alloc]
                                initWithIndex:index
                                value:board[index]];
        [_squares addObject:square];
    }
    
    // default number of random squares are predefined
    int i = 0;
    while (i < rowsPredefined)
    {
        NSInteger rand = arc4random()%[SudokuSquare maxIndex];
        SudokuSquare *square = [self squareOnIndex:rand];
        if (square.isPredefined) continue;
        else square.predefined = YES;
        i++;
    }
}

bool canInsertSquare(int index, int value) {
    int sqRowId = (index / 27);
    int sqColId = (index % 9) / 3;
    for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
            if (board[sqRowId * 27 + sqColId * 3 + i * 9 + j] == value)
                return false;
    return true;
}

bool canInsertColumn(int index, int value) {
    int rowId = index / 9;
    int colId = index % 9;
    
    for (int i=0; i<rowId; i++)
        if (board[i * 9 + colId] == value)
            return false;
    return true;
}

bool canInsert(int index, int value) {
    return canInsertSquare(index, value) && canInsertColumn(index, value);
}

void zeroRow(int row) {
    for (int i=row * 9; i < row * 9 + 9; i++)
        board[i] = -1;
}

int generateRandom (int i) { return std::rand()%i; }

bool fill(int row)
{
    
    int rowtable[9];
    //std::cout << "Starting row:" << row << endl;
    if (row == 9)
        return true;
    
    bool tableFillSucceeded = false;
    do {
        for (int i = 0; i < 9; i++)
        {
            rowtable[i] = i+1;
        }
        std::random_shuffle(rowtable, &rowtable[9], generateRandom);
        int possibleToFill = 0;
        
        for (int i = 0; i < 9; i++)
        {
            int sqId = row * 9 + i;
            for (int r = 0; r < 9; r++) {
                if (rowtable[r] == -1 || !canInsert(sqId, rowtable[r]))
                    continue;
                board[sqId] = rowtable[r];
                rowtable[r] = -1;
                possibleToFill++;
                break;
            }
        }
        //std::cout << "ptf" << possibleToFill << endl;
        if (possibleToFill < 9) { //nie udalo nam sie wrzucic tego roła
            zeroRow(row);
            return false;
        }
        
        tableFillSucceeded = fill(row + 1);
    }
    while (!tableFillSucceeded);
    return true;
}

bool isBoardValid()
{
    //wiersze
    for (int i = 0; i < 9; i++)
    {
        set<int> seen;
        for (int j = 0; j < 9; j++)
        {
            int sqId = i*9 + j;
            if (seen.find(board[sqId]) != seen.end())
                return false;
            seen.insert(board[sqId]);
        }
    }
    
    // kolumny
    for (int i = 0; i < 9; i++)
    {
        set<int> seen;
        for (int j = 0; j < 9; j++)
        {
            int sqId = j*9 + i;
            if (seen.find(board[sqId]) != seen.end())
                return false;
            seen.insert(board[sqId]);
        }
    }
    
    // square'y
    for (int i = 0; i < 3; i++)
    {
        for (int j=0 ; j < 3; j++)
        {
            set<int> seen;
            for (int k = 0; k < 3; k++)
            {
                for (int m=0; m < 3; m++)
                {
                    int sqId = i*27 + k*9 + j*3 + m;
                    if (seen.find(board[sqId]) != seen.end())
                        return false;
                    seen.insert(board[sqId]);
                }
            }
        }
    }
    return true;
}
@end
