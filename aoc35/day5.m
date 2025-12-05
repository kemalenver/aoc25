//
//  day5.m
//  aoc35
//

#import "day5.h"

NSMutableArray *processedLines;
NSMutableArray *numbersToCheck;

@implementation Day5

// Test input = 3
+ (void)part1 {

    NSLog(@"Solving Day 5 Part 1");
    [Day5 readInput];

    long totalFresh = 0;

    for(NSNumber *num in numbersToCheck) {

        for (NSArray *range in processedLines) {
            long start = [range[0] longValue];
            long end = [range[1] longValue];

            if (num.longValue >= start && num.longValue <=end) {
                totalFresh++;
                break;
            }
        }


    }



    NSLog(@"Total %ld", totalFresh);



}

// Test input = 14
// final 343329651880509
+ (void)part2 {

    NSLog(@"Solving Day 5 Part 2");

    [Day5 readInput];



    // Obj C - COME ON!
    [processedLines sortUsingComparator: ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        long obj1Min = [obj1[0] longValue];
        long obj2Min = [obj2[0] longValue];

        if (obj1Min < obj2Min) return NSOrderedAscending;

        if (obj1Min > obj2Min) return NSOrderedDescending;

        return NSOrderedSame;

    }];

    for (int i = 0; i < processedLines.count - 1;) {
        NSMutableArray *range1 = processedLines[i];
        NSMutableArray *range2 = processedLines[i+1];

        long range1Min = [range1[0] longValue];
        long range1Max = [range1[1] longValue];

        long range2Min = [range2[0] longValue];
        long range2Max = [range2[1] longValue];

        // OH MY GOD THIS WAS WRONG BECUASE  I DID < INSTEAD OF <=
        if(range2Min >= range1Min && range2Min <= range1Max) {

            NSNumber *maxNum = [NSNumber numberWithLong: MAX(range1Max, range2Max)];
            NSNumber *minNum = [NSNumber numberWithLong: MIN(range1Min, range2Min)];

            [range1 setObject:maxNum atIndexedSubscript:1];
            [range1 setObject:minNum atIndexedSubscript:0];

            [processedLines removeObjectAtIndex: i+1];

        } else {
            i++;
        }
    }

    long long totalRanges = 0;
    
    for (NSArray *range in processedLines) {
        long long start = [range[0] longValue];
        long long end = [range[1] longValue];


        long long rangeSize = end - start + 1;
        totalRanges += rangeSize;
    }
    
    NSLog(@"Total %lld", totalRanges);
}


+ (void) readInput {

    NSLog(@"Reading input file...");

//    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day5-test-input.txt";
        NSString *filePath = @"/Users/kemal.enver/code/AOC25/day5-input.txt";

    NSString *fileContents = [NSString stringWithContentsOfFile: filePath
                                                       encoding: NSUTF8StringEncoding
                                                          error: NULL];

    NSArray *linesArray = [fileContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];

    processedLines = [NSMutableArray new];
    numbersToCheck = [NSMutableArray new];
    bool rangeMode = true;

    for (int i=0; i<linesArray.count; i++) {
        NSString *line = linesArray[i];

        NSString *trimmedLine = [line stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if (trimmedLine.length==0) {
            rangeMode = false;
            continue;
        }

        if (rangeMode) {

            long long startRange = [[trimmedLine componentsSeparatedByString:@"-"][0] longLongValue];
            long long endRange = [[trimmedLine componentsSeparatedByString:@"-"][1] longLongValue];

            NSNumber *startRangeNum = [NSNumber numberWithLong: startRange];
            NSNumber *endRangeNum = [NSNumber numberWithLong: endRange];

            [processedLines addObject: [NSMutableArray arrayWithObjects:startRangeNum, endRangeNum, nil]];
        } else {
            NSNumber *freshNum = [NSNumber numberWithLong:trimmedLine.longLongValue];
            [numbersToCheck addObject:freshNum];
        }
    }

    NSLog(@"Readin done");
}

@end
