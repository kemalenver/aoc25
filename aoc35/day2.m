//
//  day2.m
//  aoc35
//
//  Created by Kemal Enver on 3/12/2025.
//

#import <Foundation/Foundation.h>
#import "day2.h"

@implementation Day2


// Test input = 1227775554
+ (void)part1 {

    NSLog(@"Solving Day 2 Part 1");
    NSArray *inputs = [Day2 readInput];

    long total = 0;

    for (NSArray *range in inputs) {
        long start = [range[0] longValue];
        long end = [range[1] longValue];

        for (long i = start; i <= end; i++)
        {
            NSString *current = [NSString stringWithFormat:@"%ld", i];

            long length = current.length;

            if (length % 2 == 1) { // Odd digits can't have a repeat?
                continue;
            }

            int halfLength = ceil(length / 2);

            NSString *firsthalf = [current substringToIndex:halfLength];
            NSRange range = NSMakeRange(halfLength, halfLength);
            NSString *secondHalf = [current substringWithRange: range];

            if ([firsthalf isEqualToString:secondHalf]) {
                total += i;
            }

        }
    }
    NSLog(@"Total: %ld", total);
}


// Test input = 4174379265
+ (void)part2 {
    // Not sure my part 1 is going to help here. Regex?

    NSLog(@"Solving Day 1 Part 2");
    NSArray *inputs = [Day2 readInput];

    long total = 0;

    for (NSArray *range in inputs) {
        long start = [range[0] longValue];
        long end = [range[1] longValue];

        for (long n = start; n <= end; n++)
        {
            NSString *current = [NSString stringWithFormat:@"%ld", n];
            long idLength = current.length;
            for (int segLength=1; segLength * 2 <= idLength; segLength++) {

                if (idLength % segLength != 0) { // Odd digits can't have a repeat?
                    continue;
                }

                bool isRepeating = true;

                NSString *firstSeg = [current substringToIndex: segLength];

                for (int pos = segLength; pos < idLength && isRepeating; pos += segLength) {

                    NSRange range = NSMakeRange(pos, segLength);
                    NSString *compSeg = [current substringWithRange: range];
                    isRepeating = [firstSeg isEqualToString: compSeg];
                }

                if (isRepeating) {
                    total += n;
                    break;
                }

            }
        }
    }

    NSLog(@"Count %ld", total);

}

+ (NSArray *) readInput {

    NSLog(@"Reading input file...");

//    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day2-test-input.txt";
    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day2-input.txt";

    NSString *fileContents = [NSString stringWithContentsOfFile: filePath
                                                       encoding: NSUTF8StringEncoding
                                                          error: NULL];

    NSArray *rangesArray = [fileContents componentsSeparatedByString: @","];


    NSMutableArray *processedLines = [NSMutableArray new];

    for (NSString *line in rangesArray) {

        // Don't forget to trim :SIGH:
        NSString *trimmedLine = [line stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if (trimmedLine.length==0) {
            break;
        }
        long long startRange = [[trimmedLine componentsSeparatedByString:@"-"][0] longLongValue];
        long long endRange = [[trimmedLine componentsSeparatedByString:@"-"][1] longLongValue];

        NSNumber *startRangeNum = [NSNumber numberWithLong: startRange];
        NSNumber *endRangeNum = [NSNumber numberWithLong: endRange];

        [processedLines addObject: [NSArray arrayWithObjects:startRangeNum, endRangeNum, nil]];
    }

    return processedLines;
}

@end
