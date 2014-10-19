//
//  SudokuSquare.h
//  Monoku
//
//  Created by Monika Pawluczuk on 03.06.2014.
//  Copyright (c) 2014 Monika Pawluczuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuSquare : NSObject
@property (nonatomic) NSInteger index; // index 0-80
@property (nonatomic) NSInteger sector; // 0-8 - to which 3x3dim sector belongs
@property (nonatomic) NSInteger column; // 0-8
@property (nonatomic) NSInteger row; // 0-8
@property (nonatomic) NSInteger value; // value stored by square
@property (nonatomic, getter = isPredefined) BOOL predefined;

-(instancetype)initWithIndex: (NSInteger)index value:(NSInteger)value;

+ (NSInteger) maxValue;
+ (NSInteger) maxIndex;
@end
