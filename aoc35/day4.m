//
//  day4.m
//  aoc35
//
//  Created by Kemal Enver on 5/12/2025.
//

#import "day4.h"


//const int gSize = 10;
const int gSize = 138;

typedef struct {
    bool grid[gSize][gSize];
} BoolGrid;

@implementation Day4


// Test input = 13
+ (void)part1 {

    NSLog(@"Solving Day 4 Part 1");
    BoolGrid w = [Day4 readInput];


    long total = 0;

    for (int i=0; i <= gSize-1; i++) {

        for (int j=0; j <= gSize-1; j++) {

            int adjTotal = [Day4 adjacentInGrid:w x:i y:j];
            bool isRoll = w.grid[i][j];
            if( isRoll && adjTotal < 4) {
                total++;

            }
        }
    }


    NSLog(@"Total: %ld", total);

}

// Test input = 43
+ (void)part2 {

    NSLog(@"Solving Day 4 Part 2");

    BoolGrid w = [Day4 readInput];

    long total = 0;

    while(true) {

        long tmpTotal = 0;

        for (int i=0; i <= gSize-1; i++) {

            for (int j=0; j <= gSize-1; j++) {

                int adjTotal = [Day4 adjacentInGrid:w x:i y:j];
                bool isRoll = w.grid[i][j];
                if( isRoll && adjTotal < 4) {
                    tmpTotal++;
                    w.grid[i][j] = false;

                }
            }
        }


        if (tmpTotal == 0) {
            break;
        }

        total += tmpTotal;

    }

    NSLog(@"Total %ld", total);
}

+ (int)adjacentInGrid:(BoolGrid)adj x:(int)x y:(int)y {
    int total = 0;

    // tl
    if (x > 0 && y > 0 && adj.grid[x-1][y-1]) { total++; }

    // l
    if (x > 0 && adj.grid[x-1][y]) { total++; }

    // bl
    if (x > 0 && y < gSize-1 && adj.grid[x-1][y+1]) { total++; }

    // b
    if (y > 0 && adj.grid[x][y-1]) { total++; }

    // a
    // Checking y+1 requires y < 9
    if (y < gSize-1 && adj.grid[x][y+1]) { total++; }

    // tr
    if (x < gSize-1 && y > 0 && adj.grid[x+1][y-1]) { total++; }

    // r
    if (x < gSize-1 && adj.grid[x+1][y]) { total++; }

    // br
    if (x < gSize-1 && y < gSize-1 && adj.grid[x+1][y+1]) { total++; }

    return total;
}

+ (BoolGrid) readInput {

    NSLog(@"Reading input file...");

//    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day4-test-input.txt";
    NSString *filePath = @"/Users/kemal.enver/code/AOC25/day4-input.txt";

    NSString *fileContents = [NSString stringWithContentsOfFile: filePath
                                                       encoding: NSUTF8StringEncoding
                                                          error: NULL];

    NSArray *linesArray = [fileContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];

    // GOnna have to go a bit c here. ObjC is too horrible for this bit.
    // Grid class would be nice...
    // hard code based on the input
    BoolGrid grid = { false };

    for (int i = 0; i<linesArray.count; i++) {
        NSString *line = linesArray[i];
        for (int j=0; j<line.length; j++) {
            bool c = [line characterAtIndex:j] == '@';
            grid.grid[i][j] = c;
        }
    }

    return grid;
}

@end
