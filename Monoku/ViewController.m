//
//  ViewController.m
//  Monoku
//
//  Created by Monika Pawluczuk on 03.06.2014.
//  Copyright (c) 2014 Monika Pawluczuk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) Game *sudokuGame;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textSquares;

@end

@implementation ViewController
- (IBAction)exitedSquare:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)touchDown:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)editEnded:(id)sender
{
    NSInteger index = [_textSquares indexOfObject:sender];
    UITextField *square = [_textSquares objectAtIndex:index];
    
    if ([square.text  isEqual: @""]) return;
    
    NSInteger value = [square.text integerValue];
    if (![_sudokuGame enterValue:value])
    {
        [self showAlertInvalidValue];
        square.text = @"";
    }
    [self updateUI];
}
- (IBAction)editBegin:(id)sender
{
    NSInteger index = [_textSquares indexOfObject:sender];
    [_sudokuGame setCurrentSquare:index];
}

- (IBAction)replayButtonTouched:(id)sender
{
    [self replay];
    [self updateUI];
}

- (void)replay
{
    _sudokuGame = [[Game alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_sudokuGame = [[Game alloc] init];
	[self updateUI];
    
}

- (void)updateUI
{
    [self showScore];
    [self setSquares];
    [self disablePredefinedSquares];
    [self isGameOver];
}

- (void)isGameOver
{
    if (![_sudokuGame gameOver]) return;
    [self showAlertEndOfGame];
}

-(void)disablePredefinedSquares
{
    for (int i =0; i < 81; i++)
    {
        if (![_sudokuGame isPredefined:i]) continue;
        UITextField *square = [_textSquares objectAtIndex:i];
        square.enabled = NO;
    }
}

-(void)setSquares
{
    for (int i =0; i < 81; i++)
    {
        UITextField *square = [_textSquares objectAtIndex:i];
        NSString *title = ([_sudokuGame isPredefined:i])?
        [NSString stringWithFormat:@"%ld",(long)[_sudokuGame valueAtSquare:i]] : @"";
        square.text = title;
        square.enabled = YES;
        
    }
}

-(void)showScore
{
    NSString *score = [NSString stringWithFormat:@"%ld",(long)[_sudokuGame score]];
    [self scoreLabel].text = score;
}

- (void)showAlertInvalidValue
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect value!"
        message:@"Try again."
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    [alert show];

}

- (void)showAlertEndOfGame
{
    NSString *winningMsg = [NSString stringWithFormat:@"You won, with score of %ld points.",(long)[_sudokuGame score]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
        message:winningMsg
        delegate:nil
        cancelButtonTitle:@"Replay"
        otherButtonTitles:nil];
    [alert show];
    [self replay];
    [self updateUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
