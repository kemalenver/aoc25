//
//  day3.m
//  aoc35
//

#import "day3.h"

@implementation Day3


// Test input = 357
+ (void)part1 {

    NSLog(@"Solving Day 3 Part 1");
    NSArray *inputs = [Day3 readInput];

    long total = 0;

    for (NSArray<NSNumber *> *bank in inputs) {

        long tmp = 0;

        for (long i=0; i < bank.count; i++) {

            for (long j=0; j< bank.count; j++) {

                if (i < j) {
                    // Oh my word look at this mess.
                    NSString *concString = [NSString stringWithFormat:@"%ld%ld", bank[i].longValue, bank[j].longValue];
                    long long convertedToNum = concString.longLongValue;
                    if(tmp < convertedToNum) {
                        tmp = convertedToNum;
                    }
                }
            }
        }

        total += tmp;
    }

    NSLog(@"Total %ld", total);
}


// Test input =
+ (void)part2 {
    // Not sure my part 1 is going to help here. Regex?

    NSLog(@"Solving Day 3 Part 2");
    NSArray *inputs = [Day3 readInput];




}

+ (NSArray *) readInput {

    NSLog(@"Reading input file...");

//    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day3-test-input.txt";
    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day3-input.txt";

    NSString *fileContents = [NSString stringWithContentsOfFile: filePath
                                                       encoding: NSUTF8StringEncoding
                                                          error: NULL];

    NSArray *linesArray = [fileContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];

    NSMutableArray *processedLines = [NSMutableArray new];

    for (NSString *line in linesArray) {
        NSMutableArray *characters = [NSMutableArray arrayWithCapacity:line.length];

        [line enumerateSubstringsInRange:NSMakeRange(0, line.length)
                                   options:NSStringEnumerationByComposedCharacterSequences
                                usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            long convertedStr = substring.longLongValue;
            [characters addObject:[NSNumber numberWithLong:convertedStr]];
        }];

        [processedLines addObject: characters];

    }

    return processedLines;
}

@end
