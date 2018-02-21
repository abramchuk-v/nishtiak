//
//  StarShipsManager.m
//  WoWiLLIDANtASK
//
//  Created by Uladzislau Abramchuk on 18.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

#import "StarShipsManager.h"
#import "StarShip.h"
#import "FileManager.h"


@implementation StarShipsManager

+ (void)getStarShips: (BOOL)isSorted : (completion)completionBlock
{
    // try to load from file
    if ([FileManager isFileExist]){
        if (isSorted) {
            NSArray *sortedArr = [StarShipsManager sortShipsByClass:[FileManager readFromJSON]];
            completionBlock(sortedArr);
        }else {
            completionBlock([FileManager readFromJSON]);
        }
        return;
    }
    
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://swapi.co/api/starships/"]];
    [urlRequest setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:
                                      urlRequest completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          if(httpResponse.statusCode == 200)
                                          {
                                              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              StarShipsManager *manager = [[StarShipsManager alloc] init];
                                              manager.count = json[@"count"];
                                              manager.previous = json[@"previous"];
                                              manager.next = json[@"next"];
                                              manager.ships = [NSMutableArray array];
                                              
                                              for (NSDictionary *dict in json[@"results"]) {
                                                  StarShip *ship = [StarShip fromData:dict];
                                                  [manager.ships addObject:ship];
                                              }
                                              
                                              [manager performQuery:manager.next :^(NSArray *arr) {
                                                  [manager.ships addObjectsFromArray:arr];
                                                  [FileManager writeStarShipsToJSON:manager.ships];
                                                  
                                                  if (isSorted) {
                                                      NSArray *sortedShips = [StarShipsManager sortShipsByClass:manager.ships];
                                                      completionBlock(sortedShips);
                                                  }else {
                                                      completionBlock(manager.ships);
                                                  }
                                                  
                                              }];
                                              [session invalidateAndCancel];
                                          }
                                      }];
    [dataTask resume];
}

-(void)performQuery:(NSString *)next : (completion)completionBlock {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:next]];
    [urlRequest setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          if(httpResponse.statusCode == 200)
                                          {
                                              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              StarShipsManager *manager = [[StarShipsManager alloc] init];
                                              manager.ships = [NSMutableArray array];
                                              for (NSDictionary *dict in json[@"results"]) {
                                                  StarShip *ship = [StarShip fromData:dict];
                                                  [manager.ships addObject:ship];
                                              }
                                              
                                              
                                              manager.next = json[@"next"];
                                              if (manager.next == (id)[NSNull null]) {
                                                  completionBlock(manager.ships);
                                                  [session invalidateAndCancel];
                                                  return;
                                              }
                                              
                                              
                                              [manager performQuery:manager.next :^(NSArray *arr) {
                                                  [manager.ships addObjectsFromArray:arr];
                                                  
                                                  completionBlock(manager.ships);
                                                  [session invalidateAndCancel];
                                              }];
                                          }
                                      }];
    [dataTask resume];
}



+(NSArray *)sortShipsByClass: (NSArray *)arr
{
    NSMutableSet *sectionsName =  [NSMutableSet set];
    for (StarShip *ship in arr) {
        [sectionsName addObject:[ship.starshipClass lowercaseString]];
    }
    NSMutableArray *shipsWithSections = [NSMutableArray array];
    
    
    
    for (NSString *className in sectionsName) {
        
        NSMutableArray *ships = [NSMutableArray array];
        [shipsWithSections addObject:ships];
        
        for (StarShip *starship in arr) {
            
            if ([[starship.starshipClass lowercaseString] isEqualToString:className]) {
                [ships addObject:starship];
            }
        }
    }
    return [shipsWithSections copy];
}


@end

