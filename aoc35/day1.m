//
//  day1.m
//  aoc35
//

#import <Foundation/Foundation.h>
#import "day1.h"

@implementation Day1

+ (void)solve {

    NSLog(@"Solving Day 1");
    NSArray *inputs = [Day1 readInput];

    int numbersOnDial = 100;
    int currentValue = 50;
    int zeroCount = 0;

    for (NSArray *instruction in inputs) {

        NSString *direction = instruction[0];
        long amount = ((NSNumber *)instruction[1]).longValue;;

        if ([direction isEqualToString:@"L"]) {
            amount = amount * -1;
        }

        currentValue = (currentValue + amount) % numbersOnDial;

        if (currentValue == 0) {
            zeroCount++;
        }
    }

    NSLog(@"Answer is %d", zeroCount);

}

+ (NSArray *) readInput {

    NSLog(@"Reading input file...");

    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day1-input-a.txt";

    NSString *fileContents = [NSString stringWithContentsOfFile: filePath
                                                       encoding: NSUTF8StringEncoding
                                                          error: NULL];

    NSArray *linesArray = [fileContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];

    NSMutableArray *processedLines = [NSMutableArray new];

    for (NSString *line in linesArray) {

        if (line.length==0) {
            break;
        }
        NSString *direction = [line substringToIndex:1];
        NSString *amountStr = [line substringFromIndex:1];

        long amountLong = [amountStr integerValue];

        NSNumber *amount = [NSNumber numberWithLong: amountLong];

        [processedLines addObject: [NSArray arrayWithObjects:direction, amount, nil]];
    }

    return processedLines;
}

@end
