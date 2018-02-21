//
//  ViewController.m
//  WoWiLLIDANtASK
//
//  Created by Uladzislau Abramchuk on 18.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

#import "ViewController.h"
#import "StarShipsManager.h"
#import "StarShip.h"


@interface ViewController ()
@property (nonatomic, strong) NSArray *ships;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [StarShipsManager getStarShips:YES :^(NSArray *arr){
        self.ships = arr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"rec"];
    StarShip *ship = self.ships[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = ship.model;
    cell.textLabel.text = ship.name;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    StarShip *ship = self.ships[section][0];
    return ship.starshipClass;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)(self.ships[section]) count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ships.count;
}


@end



